module MicropostsHelper

    def count_comment(comment)
        count = comment.count();
        return "(#{count})" if count > 0 
    end
end
