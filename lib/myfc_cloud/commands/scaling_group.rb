# encoding: utf-8
module MyfcCloud
  module Commands
    class ScalingGroup

      def initialize(configuration)
        @configuration = configuration
      end

      # TOSPEC
      def info
        raise "AutoScalingGroup named '#{scaling_group.name}' does not exist" unless scaling_group.exists?
        {
          :name => scaling_group.name,
          :min_size => scaling_group.min_size,
          :max_size => scaling_group.max_size,
          :desired_capacity => scaling_group.desired_capacity,
          :created_at => scaling_group.created_time,
          :availability_zones => scaling_group.availability_zone_names,
          :launch_configuration => scaling_group.launch_configuration_name,
          :instance_ids => scaling_group.auto_scaling_instances.map(&:instance_id),
          :load_balancers => scaling_group.load_balancer_names,
          :tags => scaling_group.tags,
        }
      end

      # TOSPEC
      def freeze(size=nil)
        size = scaling_group.desired_capacity if size.blank?
        scaling_group.update(
          :min_size => size,
          :max_size => size,
          :desired_capacity => size
        )
        size
      end

      private

      def scaling_group
        @scaling_group ||= AWS::AutoScaling.new(
          :access_key_id => @configuration.access_key_id,
          :secret_access_key => @configuration.secret_access_key
        ).groups[@configuration.auto_scaling_group_name]
      end

    end
  end
end
