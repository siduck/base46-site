package main

type ComplexData struct {
	ID     uint32   `json:"id"`
	Name   string   `json:"name"`
	Values []uint32 `json:"values"`
}

func NewComplexData(id uint32, name string) ComplexData {
	values := []uint32{id * 10, id * 20}
	return ComplexData{
		ID:     id,
		Name:   name,
		Values: values,
	}
}

func (c *ComplexData) Calculate() float64 {
	if len(c.Values) == 0 {
		return 0
	}
	sum := 0.0
	for _, v := range c.Values {
		sum += float64(v)
	}
	return sum / float64(len(c.Values))
}

func GenerateData(count uint32) map[uint32]ComplexData {
	data := make(map[uint32]ComplexData)
	for i := uint32(1); i <= count; i++ {
		data[i] = NewComplexData(i, fmt.Sprintf("Item %d", i))
	}
	return data
}

func SaveToFile(filename string, data map[uint32]ComplexData) error {
	file, err := os.Create(filename)
	if err != nil {
		return err
	}
	defer file.Close()

	encoder := json.NewEncoder(file)
	encoder.SetIndent("", "  ")
	return encoder.Encode(data)
}

func main() {
	data := GenerateData(10)

	fmt.Println("Processing data...")
	time.Sleep(2 * time.Second)

	fmt.Println("\nGenerated Data:")
	var wg sync.WaitGroup
	for id, item := range data {
		wg.Add(1)
		go func(id uint32, item ComplexData) {
			defer wg.Done()
			fmt.Printf("%d: %+v => Average: %.2f\n", id, item, item.Calculate())
		}(id, item)
	}
	wg.Wait()

	if err := SaveToFile("data_output.json", data); err != nil {
		fmt.Printf("Error saving data: %v\n", err)
	} else {
		fmt.Println("\nData successfully saved to 'data_output.json'.")
	}
}
