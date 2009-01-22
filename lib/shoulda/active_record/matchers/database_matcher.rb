module Shoulda # :nodoc:
  module ActiveRecord # :nodoc:
    module Matchers # :nodoc:

      class DatabaseMatcher
        def initialize(macro, column)
          @macro  = macro
          @column = column
        end

        def matches?(subject)
          @subject = subject
          column_exists?
        end

        def failure_message
          "Expected #{expectation}"
        end

        def negative_failure_message
          "Did not expect #{expectation}"
        end

        def description
          "#{macro_description} #{@column}"
        end

        protected

        def column_exists?
          if model_class.column_names.include?(@column.to_s)
            true
          else
            @missing = "#{model_class} does not have a db column named #{@column}."
            false
          end
        end

        def model_class
          @subject.class
        end

        def expectation
          "#{model_class.name} to have a db column named #{@column}"
        end
        
        def macro_description
          case @macro.to_s
          when 'has_db_column' then 'has db column'
          end
        end
      end

      def has_db_column(column)
        DatabaseMatcher.new(:has_db_column, column)
      end

    end
  end
end