namespace :db do
  namespace :seed do
    desc 'Seed banners'
    task :banners, [:slot_count, :content_count, :max_content_per_slot] => :environment do |t, args|
      puts args.inspect
      tool = Seed::Banners.new
      tool.run(Integer(args[:slot_count]), Integer(args[:content_count]), Integer(args[:max_content_per_slot]))
    end
  end
end
