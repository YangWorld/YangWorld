return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.2.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 48,
  height = 48,
  tilewidth = 48,
  tileheight = 48,
  nextlayerid = 6,
  nextobjectid = 2,
  properties = {},
  tilesets = {
    {
      name = "yang-tileset",
      firstgid = 1,
      filename = "../tilesets/yang-tileset.tsx",
      tilewidth = 48,
      tileheight = 48,
      spacing = 0,
      margin = 0,
      columns = 30,
      image = "../images/yang-tileset.png",
      imagewidth = 1440,
      imageheight = 810,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 48,
        height = 48
      },
      properties = {},
      terrains = {},
      tilecount = 480,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      id = 4,
      name = "ground",
      x = 0,
      y = 0,
      width = 48,
      height = 48,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJztzrEJACAQBMFrzLf/rmxAMHpQnGCSjbaSFAAAADQbmzYv+PL/Bv/+f/4HAAAAOFnMUi4f"
    },
    {
      type = "objectgroup",
      id = 5,
      name = "player",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 1,
          name = "",
          type = "",
          shape = "point",
          x = 912,
          y = 960,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
