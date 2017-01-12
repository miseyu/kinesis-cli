module Tools
  class Kinesis
    attr_reader :kinesis, :stream_name
    def initialize(region: 'ap-northeast-1', stream_name: )
      @kinesis = Aws::Kinesis::Client.new region: region
      @stream_name = stream_name
    end

    def get_shard_iterator(shard_id: '0', shard_iterator_type: 'LATEST')
      result = kinesis.get_shard_iterator stream_name: stream_name, shard_id: shard_id,
       shard_iterator_type: shard_iterator_type
      result.shard_iterator
    end

    def get_records(shard_iterator: , limit: 1000)
      kinesis.get_records shard_iterator: shard_iterator, limit: limit
    end

    def recursive_records(shard_iterator: , sleep_seconds: 1, counter: 0)
      result = get_records(shard_iterator: shard_iterator)
      Tools.logger.debug(result.inspect)
      counter += result.records.size if result.records.present?
      Tools.logger.debug("counter = #{counter}")
      return if result.next_shard_iterator.blank?
      sleep sleep_seconds
      recursive_records(shard_iterator: result.next_shard_iterator, counter: counter)
    end

    def put_record()
    end

  end
end
