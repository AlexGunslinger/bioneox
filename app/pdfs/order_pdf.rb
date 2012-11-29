class OrderPdf < Prawn::Document
  def initialize(orders, view)
    super(top_margin: 70)
    @orders = orders
    @view = view
    header
    orders_table
    total_orders
  end
  
  def header
    pigs = "#{Rails.root}/app/assets/images/interface/bioneox.png" 
    image pigs, :width => 100
    #pdf.text "<b> Del: #{desdet} Al: #{hastat} </b>", :size => 8, :align => :right, :kerning => true
    #pdf.text "<b>#{@tit_cont} de #{suc.nombr11e}</b>", :size => 13
    text "Orders Report", size: 13, style: :bold, align: :right
  end
  
  def orders_table
    move_down 20
    table orders_rows do
      row(0).font_style = :bold
      row(0).align = :center
      #columns(1..3).align = :right
      columns(3).align = :center
      columns(0..5).size = 8
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
      self.width = 540
    end
  end

  def orders_rows
    [["Date", "Origin", "Order", "T#", "Destination", "Status"]] +
    @orders.map do |order|
      if order.order_type_id == 1
        order_desc = "#{order.items.first.quantity} - #{order.items.first.sample_type.name}"
      elsif order.order_type_id == 4
        order_desc = "#{order.description}"
      end
      order.origin_user ? origin_name = order.origin_user.name : origin_name = ""
      order.delivery_user ? delivery_name = order.delivery_user.name : delivery_name = ""
      [nice_date(order.created_at), origin_name, order_desc, order.id, delivery_name, order.status]
    end
  end
  
  def nice_date(date)
    @view.nice_date(date)
  end
  
  def total_orders
    move_down 15
    text "Total Orders: #{@orders.size}", size: 10, style: :bold
  end
end