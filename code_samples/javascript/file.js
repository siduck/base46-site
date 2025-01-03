const canvas = document.createElement("canvas");

Object.assign(canvas, { width: 600, height: 400 });
document.body.appendChild(canvas);

const ctx = canvas.getContext("2d");
const random = (min, max) => Math.random() * (max - min) + min;

class Shape {
  constructor(x, y, size, color) {
    Object.assign(this, { x, y, size, color });
  }

  draw() {
    ctx.fillStyle = this.color;
    ctx.beginPath();
    ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
    ctx.fill();
  }

  move() {
    this.x += random(-2, 2);
    this.y += random(-2, 2);
  }
}

const createShapes = (count) =>
  Array.from({ length: count }, () =>
    new Shape(random(50, 550), `hsl(${random(0, 360)}, 70%, 60%)`)
  );

const animateShapes = (shapes) => {
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  shapes.forEach((shape) => {
    shape.move();
    shape.draw();
  });
  requestAnimationFrame(() => animateShapes(shapes));
};

const shapes = createShapes(25);
animateShapes(shapes);

// Additional Code for Added Features
const addShape = () => {
  shapes.push(new Shape(random(10, 30), `hsl(${random(0, 360)}, 70%, 60%)`));
};

document.addEventListener("click", addShape);
