class Sake
  module Tasks
    def sake_tasks
      task_files.map { |file| file_tasks(file) }.flatten
    end

    def file_tasks(file)
      RakeFaker.new(file).tasks
    end

    def task_files 
      Dir["#{task_directory}/*.rake"]
    end

    def sake_file(string)
      task_files.detect do |file|
        RakeFaker.new(file).tasks.include? string
      end
    end

    def task_directory
      File.join(File.expand_path('~'), '.sake')
    end

    def task_path(file)
      file = "#{file}.rake" unless file[/.rake$/]
      File.join(task_directory, file)
    end

    def fresh_task_path(file)
      if File.exists? task_file = task_path(file)
        file_parts = task_file.split('.')
        task_file = [ file_parts[0...-1], Time.now.to_i, 'rake' ].flatten
        task_path(task_file * '.')
      else
        task 
      end
    end
  end
end