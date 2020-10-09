float y = 0;
Table table;
String infile = "data.csv";
int trows = 0, tcols;   
void setup() {
  size(700, 1300);
  background(255);
  get_Table();  //___________
}

//____________________________________________________________
void draw() {
  //  background(200,200,0);
}
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  println(e);
}

//____________________________________________________________
void get_Table() {
  table=loadTable(infile, "header");
  trows = table.getRowCount();
  tcols = table.getColumnCount();
  println("rows: "+trows+" columns: "+tcols+" in file: "+infile);
  println(table.getStringColumn("Date"));
  println(table.getStringColumn("USnewCases"));
  for (int row = 0; row < table.getRowCount(); row++) {
  }
  fill(0); //__________________________________________________________________ text color on canvas
  int dy =0;
  for ( int c = 0; c < tcols; c++)  text( table.getColumnTitle(c)+" ",10+100*c, 10); //__ header line
  dy++;
  for ( int r = 0; r < trows; r++) { //________________________________________ get data lines
    TableRow thisrow = table.getRow(r);
    for ( int c = 0; c < tcols; c++ ) text( thisrow.getString(c), 10+100*c, 10+15*dy );
    dy++;

}
}
