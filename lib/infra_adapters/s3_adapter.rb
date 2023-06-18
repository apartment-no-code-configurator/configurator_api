require 'aws-sdk-s3'

module InfraAdapters

  class S3Adapter

    #TO-DO: Implement comments
    attr_reader :s3_bucket, :backup_s3_bucket, :s3_client, :params
    def initialize(params)
      @params = params
      @s3_client = Aws::S3::Client.new(region: S3Adapter.region, credentials: S3Adapter.credentials)
    end

    def create_repo_folders
      s3_client.put_object(bucket: "#{s3_bucket}", key: "#{repo}-react-build/")
      s3_client.put_object(bucket: "#{backup_s3_bucket}", key: "#{repo}-react-build/")
      s3_client.put_object(bucket: "#{s3_bucket}", key: "#{repo}-react-native-build/")
      s3_client.put_object(bucket: "#{backup_s3_bucket}", key: "#{repo}-react-native-build/")
    end

    private

    def repo
      params[:repo]
    end

    def s3_bucket
      @s3_bucket = @s3_bucket || "apartments-cdn-s3"
      # (InfraSetting.find_by(key: 's3_bucket'))
    end

    def backup_s3_bucket
      @backup_s3_bucket = @backup_s3_bucket || "apartments-cdn-s3-backup"
      # (InfraSetting.find_by(key: 's3_backup_bucket'))
    end

    def self.region
      'ap-south-1'
      #InfraSetting.find_by(key: 'aws_region')
    end

    def self.credentials
      Aws::Credentials.new('AKIA26WHCW34KYWBNT2G', '7raDoSXtJ08yhFcLgJlS/6eEFkac1PGq1o9GD6ec')
      #Aws::Credentials.new(InfraSetting.find_by(key: 'aws_access_key'), InfraSetting.find_by(key: 'aws_access_secret_key'))
    end

  end

end
