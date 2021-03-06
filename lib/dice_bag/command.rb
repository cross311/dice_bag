require 'dice_bag/available_templates'
require 'dice_bag/project'
require 'dice_bag/config_file'
require 'dice_bag/template_file'
require 'dice_bag/default_template_file'

module DiceBag
  #This class seems a candidate to be converted to Thor, the problem is that we need to run
  #in the same process than the rake task so all the gems are loaded before dice_bag
  #is called and dice_bag can find what software is used in this project
  class Command

    def write_all(params = {})
      Project.templates_to_generate.each do |template|
        write(template, params)
      end
    end

    def write(template_name, params = {})
      template_file = TemplateFile.new(template_name)
      template_file.assert_existence
      config_file = ConfigFile.new(template_name)

      template_file.create_file(config_file, params)
    end


    def generate_all_templates
      AvailableTemplates.all.each do |template|
        generate_template(template)
      end
    end

    def generate_template(default_template)
      default_template.assert_existence
      default_template.create_file
    end

  end
end
