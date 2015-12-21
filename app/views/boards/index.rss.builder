xml.instruct!
xml.rss :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' do

  xml.channel do
    xml.title 'All A Board Alliance Associate Boards'
    xml.description 'This feed containers a listing of all Associate boards listed on the All A Board Alliance website over the past month'
    xml.link root_url
    xml.language 'en'
    xml.tag! 'atom:link', :rel => 'self', :type => 'application/rss+xml', :href => boards_url

    for board in @recent_boards
      xml.item do
        xml.title board.name
        if board.board_claimed?
          xml.contact board.user.get_name
        end
        xml.pubDate(board.created_at.rfc2822)
        xml.link board_url(board.slug)
        xml.guid board_url(board.slug)
        xml.description(h(board.description))
        for category in board.categories
          xml.category category.name
        end
      end
    end
  end
end
