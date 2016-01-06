module CustomHelpers

    # shortcut to reference global partials folder
    def render_partial(partial_name, locals={})
        partial "layouts/partials/#{partial_name}", locals: locals
    end

    # def picture_tag(opts)

    # end

    def icon_tag(id, opts={})

        # defaults
        role = opts[:role] || "img"
        fallback = opts[:fallback].to_s || ""
        title = opts[:title] || ""
        classes = opts[:class] || ""

        # fallback_img = fallback.end_with? ".png" ? true : false



        content_tag :svg, :class => classes, :title => title, :role => role do
            "<use xlink:href='##{id}'></use>"

            # if opts[:fallback]
                # if fallback_img == true
                #     "<image src='#{asset_url(opts[:fallback])}' xlink:href='' />"
                # else
                    # content_tag :desc do
                    #     opts[:fallback]
                    # end
                # end
            # end
        end
    end

    # def figure_tag(opts)
    #     content_tag :figure do
    #         if opts[:link]
    #             link_to opts[:link] do
    #                 if opts[:responsive]
    #                     resp_image_tag(opts)
    #                 else
    #                     image_tag(opts)
    #                 end
    #             end
    #         else
    #             if opts[:responsive]
    #                 resp_image_tag(opts)
    #             else
    #                 image_tag(opts)
    #             end
    #         end
    #         if opts[:caption]
    #             content_tag :figcaption do
    #                 opts[:caption]
    #             end
    #         end
    #     end
    # end
end
