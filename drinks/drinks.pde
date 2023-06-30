import java.util.*;
PImage lbeer;
PImage lcoffee;
PImage lcola;
PImage lliquor;
PImage ltea;
PImage lwater;
PImage lwine;
PImage lperson;
PImage lcircle;
PImage greyscale;
boolean rectOver = false;
PFont myFont;
HashMap<String,String> popular = new HashMap<String,String>();
List<String> drinkType = Arrays.asList("Water","Coffee","Tea","Soda","Beer","Wine","MixedAlcohol");
int days = 6;
float [][] scores = new float[days][drinkType.size()];
ArrayList<Body> drinks = new ArrayList();
ArrayList<Button> buttons = new ArrayList();
int startingAngle = 0;
String filename;

float xOffset = 0;
float yOffset = 30;
float buttonGap = 15;
int mousePressThresh = 10;
float max = 0;
int mouseTime;

int state = 0;

float k = 10;

void setup() {
  size(750,750);
  imageMode(CENTER);
  myFont = createFont("zx_spectrum-7_bold.ttf", 32);
  
  lcircle = loadImage("circle.png");
  lbeer = loadImage("beer.png");
  lperson = loadImage("human.png");
  lcoffee = loadImage("coffee.png");
  lcola = loadImage("cola.png");
  lliquor = loadImage("liquor.png");
  ltea = loadImage("tea.png");
  lwater = loadImage("water.png");
  lwine = loadImage("wine.png");
  
  List<PImage> images = Arrays.asList(lwater,lcoffee,ltea,lcola,lbeer,lwine);
 
  
  // initialize empty score matrices
  for (int i = 0; i < days; i++){
    for (int j = 0; j < drinkType.size(); j++){
      scores[i][j] = 0;
    }
  }
  
  
  // read csv and save data
  filename = "tracker.csv";
  Table dataCSV = loadTable(filename, "header, csv");
  // i for day during initialization
  int i = 0;
  for (TableRow dataRow : dataCSV.rows()){
    if(dataRow.getInt("Water") == 0){
      for (String item : drinkType) {
          popular.put(item, dataRow.getString(item));
        }
        continue;
    }
    for (String item : drinkType) {
      scores[i][drinkType.indexOf(item)] = dataRow.getFloat(item);
    }
    i+=1;
  }
  float t;
 
  for (int g = 0; g<days; g++) {
    for (int g2 = 0; g2<drinkType.size(); g2++){
      t = scores[g][g2];
      if (t > max){
        max=t;
      }
    }
  }
  
  
  // Initialize Body objects and add them to drinks ArrayList
  float align = 360/6;
  for (int j = 0; j < 6; j++)
  {
     Body drink = new Body();
     drink.text = drinkType.get(j);
     drink.angle = align*j+ 0.0;
     drink.image= images.get(j);
     drink.rotate();
     drinks.add(drink);
   
  }
  
  textSize(25);
  for (int j = 0; j < 6; j++){
     Button b = new Button();
     buttons.add(b);
  }
  
  xOffset = width/2 - textWidth("Wed")*2.5 - buttonGap*2.5;
  buttons.get(0).x = xOffset;
  buttons.get(0).y = yOffset;
  buttons.get(0).text = "Tue";
  buttons.get(0).active = false;
  xOffset = xOffset + textWidth("Wed") + buttonGap;
  buttons.get(1).x = xOffset;
  buttons.get(1).y = yOffset;
  buttons.get(1).text = "Wed";
  buttons.get(1).active = false;
  xOffset = xOffset + textWidth("Wed") + buttonGap;
  buttons.get(2).x = xOffset;
  buttons.get(2).y = yOffset;
  buttons.get(2).text = "Thu";
  buttons.get(2).active = false;
  xOffset = xOffset + textWidth("Wed") + buttonGap;
  buttons.get(3).x = xOffset;
  buttons.get(3).y = yOffset;
  buttons.get(3).text = "Fri";
  buttons.get(3).active = false;
  xOffset = xOffset + textWidth("Wed") + buttonGap;
  buttons.get(4).x = xOffset;
  buttons.get(4).y = yOffset;
  buttons.get(4).text = "Sat";
  buttons.get(4).active = false;
  xOffset = xOffset + textWidth("Wed") + buttonGap;
  buttons.get(5).x = xOffset;
  buttons.get(5).y = yOffset;
  buttons.get(5).text = "Sun";
  buttons.get(5).active = false;

  mouseTime = millis();
}

void draw() {
  background(255);
  fill(0, 102, 153,50);
  ellipse(width/2, height/2,400 ,400);
  textSize(100);
  textAlign(CENTER);
  text("BEVERAGE CAROUSEL", width/2, 100);
    textSize(30);
  text("WEEKLY BEVERAGE INGESTION LOG", width/2, 130);
  textAlign(LEFT);
   textSize(25);
  text("CLICK THE ICON TO SEE", 35, height - textAscent()*4);
  text("THE MOST POPULAR BEVERAGE", 35, height - textAscent()*3);
   textSize(30);
  textAlign(CENTER);
  fill(0, 102, 153,20);
  strokeWeight(1);
  rectMode(CENTER);
  rect(width/2,960,600,130,10);
    fill(0, 0, 255, 200);
     textSize(30);
  text("CLICK THE ICON TO SEE DAILY CONSUMPTION", width/2, 940);
  text("CLICK THE DAY TO CHANGE DATA", width/2, 970);
  
 

  textFont(myFont);
  
  //text( "x: " + mouseX + " y: " + mouseY, mouseX, mouseY );
  float bt;
  bt = 190 + textWidth("Wed");

  if(mousePressed == true){
      if(mouseX> bt - textWidth("Wed") - mousePressThresh && mouseX <bt + textWidth("Wed") + mousePressThresh  && mouseY> yOffset - mousePressThresh && mouseY <yOffset + textAscent() +mousePressThresh){
        state = 0;
      }
      if(mouseX> bt + textWidth("Wed") + buttonGap - mousePressThresh && mouseX <bt + textWidth("Wed")*2 + buttonGap + mousePressThresh && mouseY> yOffset - mousePressThresh && mouseY <yOffset + textAscent() +mousePressThresh){
        state = 1;
      }
      if(mouseX> bt + textWidth("Wed")*2 + buttonGap*2 - mousePressThresh && mouseX <bt + textWidth("Wed")*3 + buttonGap*2 + mousePressThresh && mouseY> yOffset - mousePressThresh && mouseY <yOffset + textAscent() +mousePressThresh){
        state = 2;
      }
      if(mouseX> bt + textWidth("Wed")*3 + buttonGap*3 - mousePressThresh && mouseX <bt + textWidth("Wed")*4 + buttonGap*3 + mousePressThresh && mouseY> yOffset - mousePressThresh && mouseY <yOffset + textAscent() +mousePressThresh){
        state = 3;
      }
      if(mouseX> bt + textWidth("Wed")*4 + buttonGap*4 - mousePressThresh && mouseX <bt + textWidth("Wed")*5 + buttonGap*4 + mousePressThresh && mouseY> yOffset - mousePressThresh && mouseY <yOffset + textAscent() +mousePressThresh){
        state = 4;
      }
      if(mouseX> bt + textWidth("Wed")*5 + buttonGap*5 - mousePressThresh && mouseX <bt + textWidth("Wed")*6 + buttonGap*5.5 + mousePressThresh && mouseY> yOffset - mousePressThresh && mouseY <yOffset + textAscent() +mousePressThresh){
        state = 5;
      }
  }
  
  int z = 0;
  for(Button b: buttons){
    if (state == z)
      b.active = true;
      
    else {
      b.active = false;
    }
    if (b.active){
      fill(0, 102, 199, 80);
    }
    else {
     fill(0, 0, 255, 200);
    }
    text(b.text, b.x, b.y);
   z++;
  }
  
  // TO GET POPULAR DRINK BY TYPE
  //println(popular.get("Coffee"));
  
  // TO GET QUANTITY OF DRINK BY DAY
  // 0 for day1, 1 for day 2 etc
  // drinkType.indexOf("Coffee") replace coffee with required drink type, refer to drink type list on top
  //println((scores[1][drinkType.indexOf("Water")])*20);
  
  // set rotation speed
  float angleSpeed = 0.3;
 
  // draw and rotates the bodies
  for (Body drink:drinks)
  {
    drink.angle += angleSpeed; //increment angle
    drink.rotate();
    //println(drink.angle, drink.x, drink.y); // debug
   
    drink.makeSize(scores[state][drinkType.indexOf(drink.text)]);

  
    if(drink.size == 0){
      greyscale = drink.image.copy();
      greyscale.filter(GRAY);
      image(greyscale, (float)drink.x, (float)drink.y , 75, 75); // draws object image
    }
    else{
      image(drink.image, (float)drink.x, (float)drink.y, map(drink.size, 0, 1, 75, 125), map(drink.size, 0, 1, 75, 125)); // draws object image
    }

     if (drink.showLabel) {
       if(drink.image==lbeer){
       String show = popular.get("Beer");
    fill(0, 0, 255, 200);
      textSize(30);
      text(show, (float)drink.x , (float)drink.y-100,20);
     image(lcircle,(int)drink.x, (int)drink.y, 150 ,150); // make circle 
     fill(0, 102, 153);
     }
       if(drink.image==lcoffee){
       String show = popular.get("Coffee");
     fill(0, 0, 255, 200);
      textSize(30);
      text(show, (float)drink.x , (float)drink.y-100,20);
     image(lcircle,(int)drink.x, (int)drink.y, 150 ,150); // make circle 
     fill(0, 102, 153);
     }
       if(drink.image==lcola){
       String show = popular.get("Soda");
     fill(0, 0, 255, 200);
      textSize(30);
      text(show, (float)drink.x , (float)drink.y-100,20);
      image(lcircle,(int)drink.x, (int)drink.y, 150 ,150); // make circle 
     fill(0, 102, 153);
     }
       if(drink.image==ltea){
       String show = popular.get("Tea");
    fill(0, 0, 255, 200);
      textSize(30);
      text(show, (float)drink.x , (float)drink.y-100,20);
    image(lcircle,(int)drink.x, (int)drink.y, 150 ,150); // make circle 
     fill(0, 102, 153);
     }
       if(drink.image==lwine){
       String show = popular.get("Wine");
     fill(0, 0, 255, 200);
      textSize(30);
      text(show, (float)drink.x , (float)drink.y-100,20);
      image(lcircle,(int)drink.x, (int)drink.y, 150 ,150); // make circle
     fill(0, 102, 153);
     }
     
   
    }
  }
  
   fill(0, 102, 153);
  image(lperson, width/2, height*0.7, lperson.width*0.8, lperson.height*0.8);
   
   
}
void mouseClicked() {
  for (Body drink : drinks) {
    drink.showLabel = false;
    if (dist((float)drink.x, (float)drink.y, mouseX, mouseY) < 50) {
      drink.showLabel = true;
    }
  }
}
