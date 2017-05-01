class UI {

  float borders = 10;

  CheckBox debug = new CheckBox(10, 10, "Debug options");
  CheckBox genNewFood = new CheckBox(10, 30, "Generating new food", true);
  CheckBox genNewPoison = new CheckBox(10, 50, "Generating new poison", true);
  InfosBoard infosBoard;
  DataBar dataBar;
  HideShow arrow;
  PVector loc = new PVector();
  PVector locStorage = new PVector();
  float w;

  UI(float x, float y, float widthFrom0To) {
    loc.set(x, y);
    locStorage.set(x, y);
    w = widthFrom0To;
    arrow = new HideShow(loc.x+w, loc.y+10);
    dataBar = new DataBar(borders, 80);
  }

  void show() {
    if (arrow.display) {
      loc.x = locStorage.x;
      infosBoard = new InfosBoard(250, w, borders);
      noStroke();
      fill(100, 150);
      rect(loc.x, loc.y, w, height);
      debug.show();
      genNewFood.show();
      genNewPoison.show();
      infosBoard.show();
      dataBar.show();
    } else loc.x = -locStorage.x;
    arrow.show();
  }
}