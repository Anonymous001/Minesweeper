import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
private int bomb = 20;
private int bombN = bomb;
private int markN = bomb;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int y=0; y<NUM_ROWS; y++ ){
      for(int x=0; x<NUM_COLS; x++){
        buttons[y][x] = new MSButton(y,x);
      }
    } 
    for(int i=0;i<bomb; i++){
      setBombs();
    }
}
public void setBombs()
{
    //your code
    int row = (int)(Math.random()*20);
    int col = (int)(Math.random()*20);
    if(!bombs.contains(buttons[row][col])){bombs.add(buttons[row][col]);}
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    if(bombN==0 && markN ==0){
      return true; 
    }
    return false;
}
public void displayLosingMessage()
{
    //your code here
    String LosingMessage = "You Lose";
    int Mess= 0;
      for(int rows=7; rows<7+LosingMessage.length(); rows++ ){
         buttons[7][rows].setLabel(Character.toString(LosingMessage.charAt(Mess)));
         Mess++;
    }
    
}
public void displayWinningMessage()
{
    //your code here
    String winningMessage = "You Win";
    int Mess= 0;
      for(int rows=7; rows<7+winningMessage.length(); rows++ ){
         buttons[7][rows].setLabel(Character.toString(winningMessage.charAt(Mess)));
         Mess++;
    }
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if (mouseButton == RIGHT&&marked==false) {
          marked = true;
          markN --;
            if(bombs.contains(this)){
              bombN--; 
            }
        }

        else if(bombs.contains(this)&&marked==false){
           for(int i = 0; i<NUM_ROWS; i++){
             for(int j = 0; j<NUM_COLS; j++){ 
               buttons[i][j].clicked=true;    
             } 
            }
        displayLosingMessage();
       } 
       else if (mouseButton == RIGHT&&marked==true) {
        marked=false;
        markN ++;
        clicked=false;
        if(bombs.contains(this)){
          bombN++;
        }
      } 
        else if(countBombs(r,c)>0){label = "" + countBombs(r,c);}
        else{
          if(isValid(r+1,c) && buttons[r+1][c].isClicked()==false){ buttons[r+1][c].mousePressed();}
          if(isValid(r-1,c) && buttons[r-1][c].isClicked()==false){buttons[r-1][c].mousePressed(); }
          if(isValid(r,c-1) && buttons[r][c-1].isClicked()==false){buttons[r][c-1].mousePressed(); }
          if(isValid(r,c+1) && buttons[r][c+1].isClicked()==false){buttons[r][c+1].mousePressed();}
          if(isValid(r+1,c+1) && buttons[r+1][c+1].isClicked()==false){buttons[r+1][c+1].mousePressed(); }
          if(isValid(r-1,c-1) && buttons[r-1][c-1].isClicked()==false){buttons[r-1][c-1].mousePressed(); }
          if(isValid(r+1,c-1) && buttons[r+1][c-1].isClicked()==false){buttons[r+1][c-1].mousePressed(); }
          if(isValid(r-1,c+1) && buttons[r-1][c+1].isClicked()==false){buttons[r-1][c+1].mousePressed(); }
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r>=0 && r<20 && c>=0 && c<20){return true;}
        else{return false;}
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        if(isValid(row+1,col) && bombs.contains(buttons[row+1][col])){ numBombs +=1;}
        if(isValid(row-1,col) && bombs.contains(buttons[row-1][col])){ numBombs +=1;}
        if(isValid(row,col-1) && bombs.contains(buttons[row][col-1])){ numBombs +=1;}
        if(isValid(row,col+1) && bombs.contains(buttons[row][col+1])){ numBombs +=1;}
        if(isValid(row+1,col+1) && bombs.contains(buttons[row+1][col+1])){ numBombs +=1;}
        if(isValid(row-1,col-1) && bombs.contains(buttons[row-1][col-1])){ numBombs +=1;}
        if(isValid(row+1,col-1) && bombs.contains(buttons[row+1][col-1])){ numBombs +=1;}
        if(isValid(row-1,col+1) && bombs.contains(buttons[row-1][col+1])){ numBombs +=1;}
        return numBombs;
    }
}
