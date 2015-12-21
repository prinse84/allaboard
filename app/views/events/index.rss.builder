xml.instruct!
xml.rss :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' do

  xml.channel do
    xml.title 'All A Board Alliance Associate Events'
    xml.description 'This feed containers a listing of all Associate board events listed on the All A Board Alliance website over the past month'
    xml.link root_url
    xml.language 'en'
    xml.tag! 'atom:link', :rel => 'self', :type => 'application/rss+xml', :href => events_url

    for event in @events
      xml.item do
        xml.title event.name
        xml.pubDate(event.created_at.rfc2822)
        xml.link event_url(event.slug)
        xml.guid event_url(event.slug)
        xml.description(h(event.description))
        xml.date event.formatted_date
        xml.location event.location
        for category in event.categories
          xml.category category.name
        end
      end
    end
  end
end
