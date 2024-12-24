use std::{collections::{HashMap, HashSet}, fs::File, io::{self, Write}, thread, time::Duration};

#[derive(Debug, Clone)]
struct ComplexData {
    id: u32,
    name: String,
    values: HashSet<u32>,
}

impl ComplexData {
    fn new(id: u32, name: &str) -> Self {
        let mut values = HashSet::new();
        values.insert(id * 10);
        values.insert(id * 20);
        ComplexData {
            id,
            name: name.to_string(),
            values,
        }
    }

    fn calculate(&self) -> f64 {
        self.values.iter().map(|&v| v as f64).sum::<f64>() / self.values.len() as f64
    }
}

fn generate_data(count: u32) -> HashMap<u32, ComplexData> {
    (1..=count)
        .map(|id| (id, ComplexData::new(id, &format!("Item {}", id))))
        .collect()
}

fn save_to_file(filename: &str, data: &HashMap<u32, ComplexData>) -> io::Result<()> {
    let mut file = File::create(filename)?;
    for (id, item) in data {
        writeln!(file, "ID: {}, Name: {}, Average Value: {:.2}", item.id, item.name, item.calculate())?;
    }
    Ok(())
}

fn main() {
    let data = generate_data(10);
    
    // Simulate some time-consuming operations
    println!("Processing data...");
    thread::sleep(Duration::from_secs(2));

    println!("\nGenerated Data:");
    for (id, item) in &data {
        println!("{}: {:?} => Average: {:.2}", id, item, item.calculate());
    }

    if let Err(e) = save_to_file("data_output.txt", &data) {
        eprintln!("Error saving data: {}", e);
    } else {
        println!("\nData successfully saved to 'data_output.txt'.");
    }

    // Simulate a delayed action
    println!("\nSimulating some async-like behavior...");
    thread::sleep(Duration::from_secs(1));
    println!("Task completed!");
}
