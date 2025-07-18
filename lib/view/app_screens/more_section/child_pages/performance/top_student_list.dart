// widgets/top_students_list.dart

import 'package:flutter/material.dart';
import '../../../../../model/perfomance/top_student.dart';
import '../../../../../model/student_profile.dart';


class TopStudentsList extends StatelessWidget {
  final List<TopStudent> topStudents;
  final StudentProfile? currentStudent;

  const TopStudentsList({
    Key? key,
    required this.topStudents,
    this.currentStudent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // Handle refresh if needed
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(0),
        itemCount: topStudents.length + 1, // +1 for header
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildHeader(context);
          }

          final student = topStudents[index - 1];
          final isCurrentStudent = currentStudent != null &&
              (student.name.toLowerCase().contains(currentStudent!.studentFullname[0].toLowerCase()) ||
                  student.name.toLowerCase().contains(currentStudent!.studentFullname[1].toLowerCase()));

          return _buildStudentCard(context, student, isCurrentStudent);
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo, Colors.indigo.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.emoji_events,
            color: Colors.yellow,
            size: 32,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Top Performers',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${topStudents.length} students',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              topStudents.isNotEmpty ? topStudents.first.session : '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentCard(BuildContext context, TopStudent student, bool isCurrentStudent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: _getPositionGradient(student.position),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: isCurrentStudent
            ? Border.all(color: Colors.yellow, width: 3)
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // if (isCurrentStudent)
            //   Container(
            //     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            //     margin: const EdgeInsets.only(bottom: 8),
            //     decoration: BoxDecoration(
            //       color: Colors.yellow,
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     child: Row(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         const Icon(Icons.star, color: Colors.black, size: 16),
            //         const SizedBox(width: 4),
            //         Text(
            //           'You',
            //           style: TextStyle(
            //             color: Colors.black,
            //             fontSize: 12,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            Row(
              children: [
                _buildPositionBadge(student.position),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        student.regNumber,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${student.averageScore.toStringAsFixed(1)}%',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Average',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildInfoChip(
                  Icons.class_,
                  student.className,
                  Colors.white.withOpacity(0.2),
                ),
                const SizedBox(width: 8),
                _buildInfoChip(
                  Icons.calendar_today,
                  student.term,
                  Colors.white.withOpacity(0.2),
                ),
                const Spacer(),
                if (student.position <= 3)
                  Icon(
                    _getPositionIcon(student.position),
                    color: _getPositionIconColor(student.position),
                    size: 24,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPositionBadge(int position) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: _getPositionColor(position),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Center(
        child: Text(
          '$position',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  LinearGradient _getPositionGradient(int position) {
    switch (position) {
      case 1:
        return LinearGradient(
          colors: [Colors.amber.shade600, Colors.amber.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 2:
        return LinearGradient(
          colors: [Colors.grey.shade400, Colors.grey.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 3:
        return LinearGradient(
          colors: [Colors.orange.shade600, Colors.orange.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      default:
        if (position <= 5) {
          return LinearGradient(
            colors: [Colors.blue.shade600, Colors.blue.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
        } else {
          return LinearGradient(
            colors: [Colors.indigo.shade600, Colors.indigo.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
        }
    }
  }

  Color _getPositionColor(int position) {
    switch (position) {
      case 1:
        return Colors.amber.shade700;
      case 2:
        return Colors.grey.shade500;
      case 3:
        return Colors.orange.shade700;
      default:
        return Colors.indigo.shade600;
    }
  }

  IconData _getPositionIcon(int position) {
    switch (position) {
      case 1:
        return Icons.emoji_events;
      case 2:
        return Icons.military_tech;
      case 3:
        return Icons.workspace_premium;
      default:
        return Icons.star;
    }
  }

  Color _getPositionIconColor(int position) {
    switch (position) {
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.white;
      case 3:
        return Colors.orange.shade200;
      default:
        return Colors.white;
    }
  }
}