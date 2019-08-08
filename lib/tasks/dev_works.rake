namespace :dev_works do
  desc "Create Valid Work Types for Adding Data - Part 1 - development works"
  task create_valid_types: :environment do
    work_types = {
      "ಅಲ್ಪಸಂಖ್ಯಾತರ ಕಾಲೋನಿ ಅಭಿವೃಧ್ಧಿ"=>"Minority Colony. Development ",
      "ಇತರೆ ಸಾರ್ವಜನಿಕ ಉಪಯೋಗಿ ಕಾಮಗಾರಿಗಳು"=>"Other Civil Utility Works",
      "ಕುಡಿಯುವ ನೀರು"=>"Drinking Water",
      "ಕ್ರೀಡಾಂಗಣ ನಿರ್ಮಾಣ"=>"Sports Ground and Related Works",
      "ಗ್ರಾಮೀಣ ರಸ್ತೆ ಮತ್ತು ಚರಂಡಿ ನಿರ್ಮಾಣ"=>"Rural Roads and Drains ",
      "ಜಿಲ್ಲಾ ಮುಖ್ಯ ರಸ್ತೆಗಳು ಮತ್ತು ಸೇತುವೆಗಳು"=>"District High Ways and Bridges ",
      "ದೇವಸ್ಥಾನ ಮತ್ತು ಧಾರ್ಮಿಕ ಕೇಂದ್ರ"=>"Temple and Religious Institutions",
      "ಪ.ಜಾತಿ ಮತ್ತು ಪಂಗಡಗಳ ಕಾಲೋನಿಯ ಅಭಿವೃಧ್ಧಿ "=>"SC/ST Colony Development ",
      "ಪ್ರಾಥಮಿಕ ಮತ್ತು ಪ್ರೌಡ ಶಾಲೆ ನಿರ್ಮಾಣ/ದುರಸ್ಥಿ"=>"Primary /Secondary School Building and Repair",
      "ವಿಶೇಷ ಘಟಕ ಯೋಜನೆ"=>"Special Development Programme",
      "ವಿಶೇಷ ಘಟಕ ಯೋಜನೆ (ಎಸ್.ಸಿ.ಪಿ ಮತ್ತು ಟಿ.ಎಸ್.ಪಿ)"=>"Special Development Programme (SC/ST) ",
      "ಸಣ್ಣ ನೀರಾವರಿ ಇಲಾಖೆಯ ಬಾಂದಾರ ನಿರ್ಮಾಣ ಕಾಮಗಾರಿ "=>"Minor Irrigation Bandar Construction Works ",
      "ಸಮುದಾಯಭವನ ನಿರ್ಮಾಣ" => "Community Hall Construction",
      "ನಿಯೋಜಿಸಲಾಗಿಲ್ಲ" => "Unassigned"
    }

    work_types.each do |k,v|
      ValidType.create(
        name: v, 
        regional_name_value: k, 
        code: v.scan(/\p{Upper}/).join, 
        typed: true, 
        entity_type: ValidType::VALID_TYPES[:dev_work]
      )
      puts "Created #{v}"
    end
    Rake::Task["dev_works:migrate"].execute
  end

  desc "Migrate all previous work records to new format"
  task :migrate do
    valid_types = ValidType.joins(:regional_name)
    DevelopmentWork.all.each do |x| 
      valid_type = valid_types.where("regional_names.name" => x.name).first
      x.update(valid_type: valid_type)
      puts "Marked #{x.name} as #{valid_type.name rescue "NA"}"
    end
    DevelopmentWork.where(valid_type: nil).each do |x| 
      x.update(valid_type: ValidType.where(name: "Unassigned").first)
      puts "Marked #{x.name} as Unassigned"
    end
  end
end
