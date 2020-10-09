float y = 0;
Table table;
String infile = "data.csv";
int trows = 0, tcols;  
color kUK = color(128, 128, 255);
color kUS = color(255, 128, 128);

void setup() {
  size(700, 1000);
  background(255);
  //get_Table();  //___________
  textSize(10);

  table=loadTable(infile, "header");
  trows = table.getRowCount();
  tcols = table.getColumnCount();
  //println("rows: "+trows+" columns: "+tcols+" in file: "+infile);
  //println(table.getStringColumn("Date"));
  //println(table.getStringColumn("USnewCases"));
  getMax("FTSE100");
  getMax("Dow Jones");
  getMax("Nasdaq 100");
  getMax("S&P500");
  getMax("UKnewCases");
  getMax("USnewCases");
}

//____________________________________________________________
void draw() {
  background(255);
  pushMatrix();
  if (frameCount > 120) {
    translate(0, -frameCount/2);
  }
  get_Table();  //___________
  popMatrix();
  drawLine("FTSE100", kUK, 1);
  drawLine("Dow Jones", kUS, 1);
  drawLine("Nasdaq 100", kUS, 1);
  drawLine("S&P500", kUS, 1);
  drawBar("UKnewCases", color(kUK, 64), 2);
  drawBar("USnewCases", color(kUS, 64), 2);
}
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  println(e);
}

//____________________________________________________________
void get_Table() {

  //for (int row = 0; row < table.getRowCount(); row++) {
  //}
  fill(0, 128); //__________________________________________________________________ text color on canvas
  int dy =0;
  for ( int c = 0; c < tcols; c++)  text( table.getColumnTitle(c)+" ", 10+100*c, 10); //__ header line
  dy++;
  for ( int r = 0; r < trows; r++) { //________________________________________ get data lines
    TableRow thisrow = table.getRow(r);
    for ( int c = 0; c < tcols; c++ ) text( thisrow.getString(c), 10+100*c, 10+15*dy );
    dy++;
  }
}

float getMax(String col) {
  println("\n", col, table.getColumnCount());
  String [] colString = table.getStringColumn(col);
  float max = -9999;
  for (String s : colString) {
    max = max(max, float(s));
  }
  //println(col, " :\t", colString.length, max);
  return(max);
}

void drawLine(String col, color k, int w) {
  float max = getMax(col);
  float rows = table.getRowCount();
  String [] colString = table.getStringColumn(col);
  float x, y, r = 0;
  noFill();
  stroke(k);
  strokeWeight(w);
  beginShape();
  for (String s : colString) {
    x = map(r, 0, rows, width*0.05, width*0.95);
    y = map(float(s), 0, max, height*0.95, height*0.05);
    r++;
    vertex(x, y);
  }
  endShape();
}

void drawBar(String col, color k, float w) {
  float max = getMax(col);
  float rows = table.getRowCount();
  String [] colString = table.getStringColumn(col);
  float x, y, r = 0;
  fill(k, 32);
  stroke(k);
  strokeWeight(w);
  for (String s : colString) {
    x = map(r, 0, rows, width*0.05, width*0.95);
    y = map(float(s), 0, max, height*0.95, height*0.05);
    r++;
    line(x, height*0.95, x, y);
  }
}
