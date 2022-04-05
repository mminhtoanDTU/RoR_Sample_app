module CommentsHelper
    def reply_name(reply)
        # if current_user.id === reply.parent.user.id
        #     return "Bạn"
        # else
            return reply.parent.user.name
        # end
    end
end
