class TailCLI < Thor
  desc "execute stream_name iterator_type", "bin/tail_stream stream_name iterator_type[LATEST or TRIM_HORIZON default LATEST]"
  def execute(stream_name, iterator_type='LATEST')
    kinesis = Tools::Kinesis.new stream_name: stream_name
    iterator = kinesis.get_shard_iterator shard_iterator_type: iterator_type
    kinesis.recursive_records(shard_iterator: iterator)
  end
end
