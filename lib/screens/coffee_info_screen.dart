import 'package:flutter/material.dart';

class CoffeeInfoScreen extends StatelessWidget {
  const CoffeeInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Kopi'),
        backgroundColor: Colors.brown[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Container(
                  width: double.infinity,
                  color: Colors.brown[100],
                  child: Image.asset(
                    'assets/images/info_coffee.png', 
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.brown[200],
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.coffee,
                                size: 60,
                                color: Colors.brown[600],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Informasi Kopi',
                                style: TextStyle(
                                  color: Colors.brown[600],
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              
              
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Text(
                      'Quality of Coffee Beans',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[800],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'The quality of coffee beans can also be measured by their color. Raw coffee beans with black or dark brown spots may be damaged and could result in low-quality roasted coffee. These spots could be an indication of mold, which can contain toxins like aflatoxin. The color of coffee beans generally varies from light green to black, influenced by the level of ripeness at harvest, processing methods, and storage methods after harvesting. Well-ripened coffee beans are usually red or black, while beans that are not fully ripe will be light green. Light green coffee beans tend to have a less pleasant taste compared to beans that have ripened perfectly.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Colors.brown[700],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    
                    Text(
                      'Green Bean',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[800],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Green bean coffee refers to coffee beans that have not undergone the roasting process. These beans still have a green color and feel hard, unlike roasted coffee beans which are brown and have a strong aroma. Green beans are the initial stage of the coffee bean processing before they are ready to be brewed.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Colors.brown[700],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    
                    Text(
                      'Green Bean Classification Indicators',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[800],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'The classification and grading of green beans are determined by several factors, both overall and partially, depending on the standards applied in each country.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Colors.brown[700],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    
                    _buildFactorItem('Altitude', 'The altitude of the coffee planting location significantly impacts the quality of the coffee beans. The height of the location determines the temperature, humidity, and air pressure, which can affect the growth and development of the coffee fruit.'),

                    _buildFactorItem('Region', 'Each coffee-producing region has its own characteristics related to soil, climate, and the types of coffee present, making location an important factor in determining the flavor profile of a coffee.'),

                    _buildFactorItem('Varietas', 'There are many types of coffee, such as Arabica, Robusta, and various hybrid types that differ in flavor, strength, and uniqueness, affecting the final quality of the coffee.'),

                    _buildFactorItem('Coffee Bean Processing', 'The processing methods of coffee, such as wet, dry, and semi-washed processing, influence the flavor profile and characteristics of the coffee beans.'),

                    _buildFactorItem('Coffee Bean Size', 'The physical dimensions of coffee beans can provide information about the quality and potential flavor that emerges during roasting.'),

                    _buildFactorItem('Coffee Bean Shape and Color', 'The shape and color of coffee beans can also serve as quality indicators; some of them may reflect the level of ripeness and processing of the coffee beans.'),

                    _buildFactorItem('Number of Defective Coffee Beans and Tolerated Defects', 'This factor can reflect the harvesting, processing, and sorting of coffee beans.'),

                    _buildFactorItem('Coffee Bean Density', 'Coffee bean density refers to the specific weight of the bean. Denser beans may have different flavor characteristics.'),

                    _buildFactorItem('Cupping Quality', 'Cupping scores relate to the overall flavor profile of the coffee, including acidity, bitterness, aroma, and the general experience of sipping the coffee.'),
                    
                    const SizedBox(height: 24),
                    
                    
                    Text(
                      'Grade Assessment System',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[800],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'From various considerations, not all factors are used, depending on the processes in each country. Several grading and classification systems for green beans have also developed to meet the quality standards of green bean buyers. If there are defects in the green beans that may increase the risk of contamination, the grading system will adjust for those defects.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Colors.brown[700],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFactorItem(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.brown[600],
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Text(
              content,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.brown[600],
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}