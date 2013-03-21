# encoding: utf-8
module MyfcCloud
  module Commands
    class ScalingGroup

      def initialize(configuration)
        @configuration = configuration
      end

      # TOSPEC
      def info
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

      # TOSPEC
      def check
        asg_instances = scaling_group.auto_scaling_instances
        !asg_instances.empty? &&
          asg_instances.map(&:health_status).uniq.map(&:downcase) == ["healthy"] &&
          asg_instances.map(&:lifecycle_state).uniq.map(&:downcase) == ["inservice"]
      end

      def update(options={})
        options.symbolize_keys!
        clean_options = {}.tap do |hash|
          hash[:min_size] = Integer(options[:min_size]) unless options[:min_size].blank?
          hash[:max_size] = Integer(options[:max_size]) unless options[:max_size].blank?
          hash[:desired_capacity] = Integer(options[:desired_capacity]) unless options[:desired_capacity].blank?
          hash[:launch_configuration] = String(options[:launch_configuration]) unless options[:launch_configuration].blank?
        end
        return 'no changes to be made' if clean_options.blank?
        scaling_group.update(clean_options)
        clean_options
      end

      private

      def scaling_group
        @scaling_group ||= fetch_scaling_group
      end

      def fetch_scaling_group
        scaling_group = AWS::AutoScaling.new(
          :access_key_id => @configuration.access_key_id,
          :secret_access_key => @configuration.secret_access_key
        ).groups[@configuration.auto_scaling_group_name]
        raise "AutoScalingGroup named '#{@configuration.auto_scaling_group_name}' does not exist" unless scaling_group.exists?
        scaling_group
      end

    end
  end
end
