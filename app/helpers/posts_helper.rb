module PostsHelper
    def render_with_hashtags(body)
        body.gsub(/#\w+/){|word| link_to word,"/hashtag/#{word.downcase.delete('#')}"}.html_safe
    end
end
