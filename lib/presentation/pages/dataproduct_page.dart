import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nd/generated/locale_keys.g.dart';
import 'package:flutter_nd/presentation/blocs/bloc/dataproduct_bloc.dart';
import 'package:flutter_nd/presentation/blocs/bloc/dataproduct_event.dart';
import 'package:flutter_nd/presentation/blocs/bloc/dataproduct_state.dart';
import 'package:flutter_nd/presentation/pages/color.dart';

class DataProductPage extends StatefulWidget {
  @override
  _DataProductPageState createState() => _DataProductPageState();
}

class _DataProductPageState extends State<DataProductPage> {
  @override
  void initState() {
    super.initState();
    context.read<DataProductBloc>().add(FetchDataProduct());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Cosmetics_Products.tr()),
        backgroundColor: ColorColors.primaryColor,
      ),
      body: BlocBuilder<DataProductBloc, DataProductState>(
        builder: (context, state) {
          if (state is DataProductLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DataProductLoaded) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15.0),
                          ),
                          child: Image.asset(
                            product.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              '${product.priceTg} тг',
                              style: TextStyle(
                                color: ColorColors.secondaryColor,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is DataProductError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Center(child: Text('Welcome to Cosmetics Store'));
        },
      ),
    );
  }
}