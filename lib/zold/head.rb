# frozen_string_literal: true

# Copyright (c) 2018 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require_relative 'txn'

# Head of a wallet.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2018 Yegor Bugayenko
# License:: MIT
module Zold
  # Head of the wallet.
  class Head
    def initialize(file)
      @file = file
    end

    def flush
      # nothing
    end

    def fetch
      raise "Wallet file '#{@file}' is absent" unless File.exist?(@file)
      lines = IO.read(@file).split(/\n/)
      raise "Not enough lines in #{@file}, just #{lines.count}" if lines.count < 4
      lines.take(4)
    end

    # Cached head.
    # Author:: Yegor Bugayenko (yegor256@gmail.com)
    # Copyright:: Copyright (c) 2018 Yegor Bugayenko
    # License:: MIT
    class Cached
      def initialize(txns)
        @txns = txns
      end

      def flush
        @fetch = nil
      end

      def fetch
        @fetch ||= @txns.fetch
      end
    end
  end
end
