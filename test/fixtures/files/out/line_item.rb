# A historical record of an individual item in a fulfillment.
class LineItem
  # The ID of the line item within the fulfillment.
  # @return [String]
  attr_accessor :id
  # The ID of the product variant being fulfilled.
  # @return [String]
  attr_accessor :variant_id
  # The title of the product.
  # @return [String]
  attr_accessor :title
  # The number of items in the fulfillment.
  # @return [Integer]
  attr_accessor :quantity
  # The price of the item.
  # @return [String]
  attr_accessor :price
  # The weight of the item in grams.
  # @return [String]
  attr_accessor :grams
  # The unique identifier of the item in the fulfillment.
  # @return [String]
  attr_accessor :sku
  # The title of the product variant being fulfilled.
  # @return [String]
  attr_accessor :variant_title
  # The name of the supplier of the item.
  # @return [String]
  attr_accessor :vendor
  # The service provider who is doing the fulfillment.
  # @return [String]
  attr_accessor :fulfillment_service
  # The unique numeric identifier for the product in the fulfillment.
  # @return [String]
  attr_accessor :product_id
  # Whether a customer needs to provide a shipping address when placing an order for this product variant.
  # @return [Boolean]
  attr_accessor :requires_shipping
  # Whether the line item is taxable.
  # @return [Boolean]
  attr_accessor :taxable
  # Whether the line item is a [gift card](https://help.shopify.com/manual/products/gift-card-products).
  # @return [Boolean]
  attr_accessor :gift_card
  # The name of the product variant.
  # @return [String]
  attr_accessor :name
  # The name of the inventory management system.
  # @return [String]
  attr_accessor :variant_inventory_management
  # Any additional properties associated with the line item.
  # @return [Array<String>]
  attr_accessor :properties
  # Whether the product exists.
  # @return [String]
  attr_accessor :product_exists
  # The amount available to fulfill.
  # This is the `quantity - max (refunded_quantity, fulfilled_quantity) - pending_fulfilled_quantity - open_fulfilled_quantity`.
  # @return [String]
  attr_accessor :fulfillable_quantity
  # The total of any discounts applied to the line item.
  # @return [String]
  attr_accessor :total_discount
  # @!attribute fulfillment_status [rw]
  #   The status of an order in terms of the line items being fulfilled.
  #   Valid values: `fulfilled`, `null`, or `partial`.
  #   @return [:fulfilled, :null, :partial]
  enum fulfillment_status: [:fulfilled, :null, :partial]
  # The `title`, `price`, and `rate` of any taxes applied to the line item.
  # @return [Array<TaxLine>]
  attr_accessor :tax_lines
end
