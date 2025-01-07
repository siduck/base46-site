use std::collections::HashMap;
use std::fs::File;
use std::io::{self, Write};

// Enum to represent different shapes
enum Shape {
    Rectangle { width: u32, height: u32 },
    Triangle { base: u32, height: u32 },
    Circle(f64),
}


fn calculate_area(shape: &Shape) -> f64 {
    match shape {
       Shape::Rectangle { width, height } => (*width as f64) * (*height as f64),
        Shape::Triangle { base, height } => 0.5 * (*base as f64) * (*height as f64),
        Shape::Circle(radius) => std::f64::consts::PI * radius.powi(2),
    }
}

// create and save data to a file
fn save_data_to_file(filename: &str, data: &HashMap<String, f64>) -> io::Result<()> {
    let mut file = File::create(filename)?;
    for (key, value) in data {
        writeln!(file, "{}: {:.2}", key, value)?;
    }
    Ok(())
}

fn main() {
    println!("=== Advanced Rust Code ===\n");

    let shapes = vec![
        Shape::Rectangle { width: 10, height: 20 },
        Shape::Triangle { base: 15, height: 10 },
        Shape::Circle(7.0),
    ];

    let mut areas: HashMap<String, f64> = HashMap::new();
    for (i, shape) in shapes.iter().enumerate() {
        let key = format!("Shape {}", i + 1);
        let area = calculate_area(shape);
        areas.insert(key, area);
    }

    println!("Calculated Areas:");
    for (name, area) in &areas {
        println!("{}: {:.2}", name, area);
    }
}
