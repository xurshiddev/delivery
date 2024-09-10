import 'package:flutter/material.dart';
import 'package:yummy/models/cart_manager.dart';
import 'package:yummy/models/order_manager.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends StatefulWidget {
  final CartManager cartManager;
  final Function() didUpdate;
  final Function(Order) onSubmit;
  const CheckoutPage(
      {super.key,
      required this.cartManager,
      required this.didUpdate,
      required this.onSubmit});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // 1
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text('Delivery'),
    1: Text('Self Pick-Up'),
  };
// 2
  Set<int> selectedSegment = {0};
// 3
  TimeOfDay? selectedTime;
// 4
  DateTime? selectedDate;
// 5
  final DateTime _firstDate = DateTime(DateTime.now().year - 2);
  final DateTime _lastDate = DateTime(DateTime.now().year + 1);
// 6
  final TextEditingController _nameController = TextEditingController();
  // 1
  String formatDate(DateTime? dateTime) {
    // 2
    if (dateTime == null) {
      return 'Select Date';
    }
    // 3
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }

  // 1
  String formatTimeOfDay(TimeOfDay? timeOfDay) {
    // 2
    if (timeOfDay == null) {
      return 'Select Time';
    }
    // 3
    final hour = timeOfDay.hour.toString().padLeft(2, '0');
    final minute = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            "Order Details",
            style: textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 16.0,
          ),
          _buildOrderSegmentedType(),

          const SizedBox(
            height: 16.0,
          ),
          _buildTextField(),
          // TO DO: Add Name Textfield
          // 1
          const SizedBox(height: 16.0),
// 2
          Row(
            children: [
              TextButton(
                // 3
                child: Text(formatDate(selectedDate)),
                // 4
                onPressed: () => _selectDate(context),
              ),
              TextButton(
                // 5
                child: Text(formatTimeOfDay(selectedTime)),
                // 6
                onPressed: () => _selectTime(context),
              ),
            ],
          ),
// 7
          const SizedBox(height: 16.0),

          const Text('Order Summary'),
          _buildOrderSummary(context),
           _buildSubmitButton()
        ]),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: _firstDate,
      lastDate: _lastDate,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true,
          ),
          child: child!,
        );
      },
    );
    // 7
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void onSegmentSelected(Set<int> segmentIndx) {
    setState(() {
      selectedSegment = segmentIndx;
    });
  }

  Widget _buildTextField() {
    return TextField(
      controller: _nameController,
      decoration: const InputDecoration(label: Text('Contact Name')),
    );
  }

  Widget _buildOrderSegmentedType() {
    return SegmentedButton(
      showSelectedIcon: false,
      segments: const [
        ButtonSegment(
            value: 0,
            label: Text('Delivery    '),
            icon: Icon(Icons.pedal_bike)),
        ButtonSegment(
            value: 1, label: Text("Pickup"), icon: Icon(Icons.local_mall))
      ],
      selected: selectedSegment,
      onSelectionChanged: onSegmentSelected,
    );
  }

  Widget _buildOrderSummary(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;

    return Expanded(
        child: ListView.builder(
            itemCount: widget.cartManager.items.length,
            itemBuilder: (context, index) {
              final item = widget.cartManager.itemAt(index);
              // TO DO: Wrap in a Dismissible Widget
              return Dismissible(
                // 1
                key: Key(item.id),
// 2
                direction: DismissDirection.endToStart,
// 3
                background: Container(),
// 4
                secondaryBackground: const SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.delete),
                    ],
                  ),
                ),
// 5
                onDismissed: (direction) {
                  setState(() {
                    widget.cartManager.removeItem(item.id);
                  });
                  // 6
                  widget.didUpdate();
                },

                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                      border: Border.all(
                        color: colorTheme.primary,
                        width: 2.0,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                      child: Text('x${item.quantity}'),
                    ),
                  ),
                  title: Text(item.name),
                  subtitle: Text('Price: \$${item.price}'),
                ),
              );
            }));
  }
  Widget _buildSubmitButton() {
  // 1
  return ElevatedButton(
    // 2
    onPressed: widget.cartManager.isEmpty
        ? null
        // 3
        : () {
            final selectedSegment = this.selectedSegment;
            final selectedTime = this.selectedTime;
            final selectedDate = this.selectedDate;
            final name = _nameController.text;
            final items = widget.cartManager.items;
            // 4
            final order = Order(
              selectedSegment: selectedSegment,
              selectedTime: selectedTime,
              selectedDate: selectedDate,
              name: name,
              items: items,
            );
            // 5
            widget.cartManager.resetCart();
            // 6
            widget.onSubmit(order);
          },
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      // 7
      child: Text(
        '''Submit Order - \$${widget.cartManager.totalCost.toStringAsFixed(2)}'''),
    ),
  );
}

}
