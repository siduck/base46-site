const canvas: HTMLCanvasElement = document.createElement("canvas");

Object.assign(canvas, { width: 600, height: 400 });
document.body.appendChild(canvas);

const ctx: CanvasRenderingContext2D = canvas.getContext("2d");
const random = (min: number, max: number): number => Math.random() * (max - min) + min;

class Shape {
  constructor(x: number, y: number, size: number, color: string) {
    Object.assign(this, { x, y, size, color });
  }

  draw(): void {
    ctx.fillStyle = this.color;
    ctx.beginPath();
    ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
    ctx.fill();
  }

  move(): void {
    this.x += random(-2, 2);
    this.y += random(-2, 2);
  }
}

const createShapes = (count: number): Shape[] =>
  Array.from({ length: count }, () =>
    new Shape(random(50, 550), random(10, 30), `hsl(${random(0, 360)}, 70%, 60%)`)
  );

const animateShapes = (shapes: Shape[]): void => {
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  shapes.forEach((shape) => {
    shape.move();
    shape.draw();
  });
  requestAnimationFrame(() => animateShapes(shapes));
};

const shapes: Shape[] = createShapes(25);
animateShapes(shapes);

// Additional Code for Added Features
const addShape = (): void => {
  shapes.push(new Shape(random(50, 550), random(10, 30), `hsl(${random(0, 360)}, 70%, 60%)`));
};

document.addEventListener("click", addShape);
