module Admin
  class MembersController < AdminController
    private

    def new_controls
      Controls.new
    end

    class Controls
      def title
        Member.name.pluralize
      end

      def model
        Member
      end

      def scope(action:)
        if action.write? || action.delete?
          raise Super::Error::Forbidden
        end

        Member.all
      end

      def permitted_params(params, action:)
        params.require(:member).permit(:name, :rank, :position, :ship_id)
      end

      def display_schema(action:)
        Super::Schema.new(Super::Display::SchemaTypes.new) do |fields, type|
          fields[:name] = type.dynamic(&:itself)
          fields[:rank] = type.dynamic(&:itself)
          fields[:position] = type.dynamic(&:itself)
          fields[:ship] = type.dynamic { |ship| "#{ship.name} (Ship ##{ship.id})" }
          fields[:created_at] = type.dynamic(&:iso8601)
          if action.show?
            fields[:updated_at] = type.dynamic(&:iso8601)
          end
        end
      end

      def form_schema(action:)
        Super::Schema.new(Super::Form::SchemaTypes.new) do |fields, type|
          fields[:name] = type.generic("form_generic_text")
          fields[:rank] = type.generic("form_generic_select", collection: Member.ranks.keys)
          fields[:position] = type.generic("form_generic_text")
          fields[:ship_id] = type.generic(
            "form_generic_select",
            collection: Ship.all.map { |s| ["#{s.name} (Ship ##{s.id})", s.id] },
          )
        end
      end
    end
  end
end
