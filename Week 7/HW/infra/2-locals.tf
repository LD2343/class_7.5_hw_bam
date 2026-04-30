resource "local_file" "fav-food" {
  filename = "${path.module}/fav_food.txt"
  content = "WaffleHouse"
}