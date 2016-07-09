require_relative '../spec_helper'
require 'timeout'

module Futurema
  describe Future do
    it 'returns a value' do
      future = Future.new { 1 + 2 }
      expect(future).to eq 3
    end

    it 'executes the computation in the background' do
      future = Future.new { sleep 1; 42 }

      sleep 1

      Timeout::timeout 0.9 do
        expect(future).to eq 42
      end
    end

    it 'captures excetions and re-raises them' do
      Thread.abort_on_exception = true

      error_msg = 'Good news, everyone!'

      future = Future.new { raise error_msg }
      expect { future.inspect }.to raise_error RuntimeError, error_msg
    end

    it 'pollutes the Kernel namespace' do
      msg = 'Do the bender!'

      future = future { msg }
      expect(future).to eq msg
    end

    it 'allows access to its value' do
      val = 10
      future = Future.new { val }

      expect(future.value).to eq val
    end
  end
end
