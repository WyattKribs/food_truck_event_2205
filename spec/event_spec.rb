require './lib/food_truck'
require './lib/item'
require './lib/event'

describe Event do
  before(:each) do
    @event = Event.new("South Pearl Street Farmers Market")
    @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    @food_truck3 = FoodTruck.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
  end

  it "is an instance of Event" do
    expect(@event).to be_a(Event)
  end

  it "has a name" do
    expect(@event.name).to eq("South Pearl Street Farmers Market")
  end

  it "has no food trucks by default" do
    expect(@event.food_trucks).to eq([])
  end

  it "can add food trucks to the event" do
    @event.add_truck(@food_truck1)
    @event.add_truck(@food_truck2)
    @event.add_truck(@food_truck3)
    expect(@event.food_trucks.count).to eq(3)
  end

  it "can tell you the names of the trucks" do
    @event.add_truck(@food_truck1)
    @event.add_truck(@food_truck2)
    @event.add_truck(@food_truck3)
    expect(@event.food_truck_names).to eq(["Rocky Mountain Pies",
      "Ba-Nom-a-Nom", "Palisade Peach Shack"])
  end

  it "can tell you what trucks sell an item" do
    @event.add_truck(@food_truck1)
    @event.add_truck(@food_truck2)
    @event.add_truck(@food_truck3)
    @food_truck1.stock(@item1, 30)
    @food_truck3.stock(@item1, 35)
    expect(@event.food_trucks_that_sell(@item1)).to eq([@food_truck1, @food_truck3])
  end

  it "can tell you what items are overstocked" do
    @event.add_truck(@food_truck1)
    @event.add_truck(@food_truck2)
    @event.add_truck(@food_truck3)
    @food_truck1.stock(@item1, 30)
    @food_truck3.stock(@item1, 50)
    @food_truck1.stock(@item2, 10)
    @food_truck2.stock(@item2, 10)
    expect(@event.overstocked_items).to eq([@item1])
  end
end
