import 'package:flutter/material.dart';
import 'package:flutter_application_8/provider/formstate_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_8/provider/category_provider.dart';


class Admincategory extends StatelessWidget {
  const Admincategory({Key? key}) : super(key: key);

  Future<void> _addCategory(BuildContext context) async {
    final formStateProvider = Provider.of<FormStateProvider>(context, listen: false);
    if (formStateProvider.nameController.text.isEmpty || formStateProvider.imageUrlController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    formStateProvider.setLoading(true);

    try {
      await Provider.of<CategoryProvider>(context, listen: false)
          .addCategory(formStateProvider.nameController.text, formStateProvider.imageUrlController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Category added successfully')),
      );

      formStateProvider.clearControllers();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add category: $e')),
      );
    } finally {
      formStateProvider.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
      ),
      body: ChangeNotifierProvider(
        create: (_) => FormStateProvider(),
        child: Consumer<FormStateProvider>(
          builder: (context, formStateProvider, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: formStateProvider.nameController,
                    decoration: const InputDecoration(labelText: 'Category Name'),
                  ),
                  TextField(
                    controller: formStateProvider.imageUrlController,
                    decoration: const InputDecoration(labelText: 'Image URL'),
                  ),
                  const SizedBox(height: 20),
                  formStateProvider.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () => _addCategory(context),
                          child: const Text('Add Category'),
                        ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Consumer<CategoryProvider>(
                      builder: (context, provider, child) {
                        return ListView.builder(
                          itemCount: provider.categories.length,
                          itemBuilder: (context, index) {
                            final category = provider.categories[index];
                            return ListTile(
                              title: Text(category.name),
                              leading: Image.network(category.imageUrl),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
