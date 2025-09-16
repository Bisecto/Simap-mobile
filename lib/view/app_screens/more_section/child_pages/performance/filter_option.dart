// widgets/filter_widgets.dart

import 'package:flutter/material.dart';

import '../../../../../model/perfomance/filter_option.dart';
import '../../../../../model/session_model.dart';

class FilterSection extends StatefulWidget {
  final FilterOptions filters;
  final Function(String term, String sessionId, String classId)
      onFiltersChanged;
  final List<SessionModel>?
      availableSessions; // Add support for your SessionModel

  const FilterSection({
    Key? key,
    required this.filters,
    required this.onFiltersChanged,
    this.availableSessions,
  }) : super(key: key);

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  late String selectedTerm;
  late String selectedSessionId;
  late String selectedClassId;

  @override
  void initState() {
    super.initState();
    selectedTerm = widget.filters.currentFilters.term;
    selectedSessionId = widget.filters.currentFilters.sessionId;
    selectedClassId = widget.filters.currentFilters.classId;
  }

  @override
  void didUpdateWidget(FilterSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.filters != widget.filters) {
      selectedTerm = widget.filters.currentFilters.term;
      selectedSessionId = widget.filters.currentFilters.sessionId;
      selectedClassId = widget.filters.currentFilters.classId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildTermFilter(),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSessionFilter(),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildClassFilter(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Term',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 35,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedTerm,
              isExpanded: true,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.indigo),
              items: widget.filters.terms.map((term) {
                return DropdownMenuItem(
                  value: term,
                  child: Text(
                    term,
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedTerm = value;
                  });
                  _applyFilters();
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSessionFilter() {
    // Use available sessions if provided, otherwise use filter sessions
    final sessionsToShow = widget.availableSessions ??
        widget.filters.sessions
            .map((s) => SessionModel(
                  id: s.id,
                  session: s.session,
                  sessionSlug: s.session.toLowerCase().replaceAll('/', '-'),
                  activeSession: false,
                  branch: 1,
                ))
            .toList();

    // Extract all available session IDs
    final availableSessionIds =
        sessionsToShow.map((s) => s.id.toString()).toSet();

    // Validate selectedSessionId - set to null if it doesn't exist in available options
    final validatedSessionId = (selectedSessionId != null &&
            availableSessionIds.contains(selectedSessionId))
        ? selectedSessionId
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Session',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 35,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: validatedSessionId,
              // Use validated value
              isExpanded: true,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.indigo),
              hint: const Text('Select',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  )),
              // Add hint for when value is null
              items: sessionsToShow.map((session) {
                return DropdownMenuItem(
                  value: session.id.toString(),
                  child: Row(
                    children: [
                      if (session.activeSession)
                        Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      Expanded(
                        child: Text(
                          session.session,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: session.activeSession
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedSessionId = value;
                  });
                  _applyFilters();
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClassFilter() {
    // Group classes by type
    final classGroups = <String, List<ClassFilter>>{};
    for (final classFilter in widget.filters.classes) {
      if (!classGroups.containsKey(classFilter.nameOfClassType)) {
        classGroups[classFilter.nameOfClassType] = [];
      }
      classGroups[classFilter.nameOfClassType]!.add(classFilter);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Class',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 35,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedClassId,
              isExpanded: true,
              padding: const EdgeInsets.symmetric(horizontal: 7),
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.indigo),
              items: widget.filters.classes.map((classFilter) {
                return DropdownMenuItem(
                  value: classFilter.id.toString(),
                  child: Text(
                    classFilter.nameOfClassType, style: const TextStyle(fontSize: 10),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedClassId = value;
                  });
                  _applyFilters();
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Color _getClassColor(String className) {
    switch (className.toUpperCase()) {
      case 'DIAMOND':
        return Colors.blue[300]!;
      case 'GOLD':
        return Colors.amber[600]!;
      case 'SILVER':
        return Colors.grey[400]!;
      case 'EMERALD':
        return Colors.green[400]!;
      case 'PEARL':
        return Colors.pink[200]!;
      default:
        return Colors.indigo[300]!;
    }
  }

  void _applyFilters() {
    widget.onFiltersChanged(selectedTerm, selectedSessionId, selectedClassId);
  }
}

class FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? selectedColor;

  const FilterChip({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.selectedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color:
              isSelected ? (selectedColor ?? Colors.indigo) : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? (selectedColor ?? Colors.indigo)
                : Colors.grey[300]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class QuickFilterBar extends StatelessWidget {
  final List<String> options;
  final String selectedOption;
  final Function(String) onOptionSelected;
  final String title;

  const QuickFilterBar({
    Key? key,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
          ),
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: options.length,
            itemBuilder: (context, index) {
              final option = options[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: option,
                  isSelected: selectedOption == option,
                  onTap: () => onOptionSelected(option),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
