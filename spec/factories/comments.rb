FactoryGirl.define do
  factory :comment do
    comment { FFaker::Name.name }
    task
    trait :include_file do |f|
      f.file {
        ActionDispatch::Http::UploadedFile.new(
          tempfile: File.new(Rails.root.join('spec/fixtures/assets/example.png')),
          filename: File.basename(File.new(Rails.root.join('spec/fixtures/assets/example.png')))
        )
      }
    end
    trait :include_long_file do |f|
      f.file {
        ActionDispatch::Http::UploadedFile.new(
          tempfile: File.new(Rails.root.join('spec/fixtures/assets/world.png')),
          filename: File.basename(File.new(Rails.root.join('spec/fixtures/assets/world.png')))
        )
      }
    end
  end
end
