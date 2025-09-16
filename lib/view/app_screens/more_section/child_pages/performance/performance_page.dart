// screens/student_performance_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:dio/dio.dart';
import 'package:simap/model/result_model/result_current_data.dart';
import 'package:simap/view/app_screens/more_section/child_pages/performance/session_performance_chart.dart';
import 'package:simap/view/app_screens/more_section/child_pages/performance/subject_improvement_chart.dart';
import 'package:simap/view/app_screens/more_section/child_pages/performance/top_student_list.dart';

import '../../../../../app_repository/repository.dart';
import '../../../../../app_repository/student_performance_repository.dart';
import '../../../../../bloc/student_performance_bloc/student_performance_bloc.dart';
import '../../../../../bloc/student_performance_bloc/student_performance_event.dart';
import '../../../../../bloc/student_performance_bloc/student_performance_state.dart';
import '../../../../../model/class_model.dart';
import '../../../../../model/perfomance/overall_performance.dart';
import '../../../../../model/perfomance/student_performance.dart';
import '../../../../../model/school_model.dart';
import '../../../../../model/session_model.dart';
import '../../../../../model/student_profile.dart';
import '../../../../../res/app_colors.dart';
import '../../../../../res/shared_preferenceKey.dart';
import '../../../../../utills/shared_preferences.dart';
import '../../../../widgets/appBar_widget.dart';
import '../../../home_section/home_page_components/welcome_container.dart';
import 'custom_chart.dart';
import 'filter_option.dart';
import 'overall_trend_chart.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:dio/dio.dart';

class PerformancePage extends StatefulWidget {
  final StudentProfile studentProfile;
  final ClassModel classModel;
  final SchoolModel schoolModel;
 /// final Session selectedSession;
  final SessionModel currentSessionModel;
  final List<SessionModel> sessionsList;

  const PerformancePage({
    Key? key,
    required this.studentProfile,
    required this.classModel,
    required this.schoolModel,
    required this.currentSessionModel,
    required this.sessionsList,
  }) : super(key: key);

  @override
  State<PerformancePage> createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final StudentPerformanceBloc _performanceBloc = StudentPerformanceBloc(
      repository: StudentPerformanceRepository(appRepository: AppRepository()));
  final String selectedTerm='First';

  @override
  void initState() {
    super.initState();
    _performanceBloc.add(const LoadStudentPerformance());
    _performanceBloc.add(LoadStudentsPerformanceInSchool(
      term: selectedTerm,
      sessionId: widget.currentSessionModel.id.toString(),
      classId: widget.classModel.id.toString(),
    ));
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentPerformanceBloc>(
      create: (context) => StudentPerformanceBloc(
        repository: StudentPerformanceRepository(
          appRepository: AppRepository(),
        ),
      )
        ..add(const LoadStudentPerformance())
        ..add(LoadStudentsPerformanceInSchool(
          term: selectedTerm,
          sessionId: widget.currentSessionModel.id.toString(),
          classId: widget.classModel.id.toString(),
        ))
        // ..add(LoadStudentPerformanceBySession(
        //   sessionId: widget.currentSessionModel.id.toString(),
        // )),
        ,
      child: Scaffold(
        backgroundColor: const Color(0xFFFCFCFC),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                MainAppBar(
                  isBackKey: true,
                  studentProfile: widget.studentProfile,
                  classModel: widget.classModel,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoCard(),
                        const SizedBox(height: 16),
                        // Tab Bar
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TabBar(
                            controller: _tabController,
                            labelColor: AppColors.primaryColor,
                            unselectedLabelColor: Colors.grey[600],
                            indicatorColor: AppColors.primaryColor,
                            indicatorWeight: 3,
                            tabs: const [
                              Tab(text: 'Overview'),
                              Tab(text: 'Rankings'),
                             // Tab(text: 'Analysis'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Tab Content
                        Expanded(
                          child: BlocConsumer<StudentPerformanceBloc,
                              StudentPerformanceState>(
                            listener: (context, state) {
                              if (state is StudentPerformanceError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(state.message),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            builder: (context, state) {
                              if (state is StudentPerformanceLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (state is StudentPerformanceError) {
                                return _buildErrorWidget(state.message);
                              }

                              if (state is StudentPerformanceLoaded) {
                                return TabBarView(
                                  controller: _tabController,
                                  children: [
                                    _buildOverviewTab(state),
                                    _buildSchoolPerformanceTab(state),
                                   // _buildSessionAnalysisTab(state),
                                  ],
                                );
                              }

                              return const Center(
                                child: Text('No data available'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _performanceBloc.add(const RefreshData());
          },
          backgroundColor: AppColors.primaryColor,
          child: const Icon(Icons.refresh, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildOverviewTab(StudentPerformanceLoaded state) {
    if (state.studentPerformance == null) {
      return const Center(child: Text('No performance data available'));
    }

    return RefreshIndicator(
      onRefresh: () async {
        _performanceBloc.add(const LoadStudentPerformance());
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Performance Chart Container (matching your original design)
            Container(
              height: 300,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: CustomChart(
                  studentPerformance: state.studentPerformance!,
                  isShowingMainData: false,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildPerformanceSummaryCard(state.studentPerformance!),
            const SizedBox(height: 16),
            _buildSubjectImprovementChart(state.studentPerformance!),
          ],
        ),
      ),
    );
  }

  Widget _buildSchoolPerformanceTab(StudentPerformanceLoaded state) {
    print('Rebuilding _buildSchoolPerformanceTab...');
    print('studentsPerformanceInSchool: ${state.studentsPerformanceInSchool}');
    return Column(
      children: [
        if (state.studentsPerformanceInSchool != null)
          FilterSection(
            filters: state.studentsPerformanceInSchool!.filters,
            availableSessions: widget.sessionsList,
            onFiltersChanged: (term, sessionId, classId) {
              //print()
              _performanceBloc.add(
                LoadStudentsPerformanceInSchool(
                  term: term,
                  sessionId: sessionId,
                  classId: classId,
                ),
              );
            },
          ),
        Expanded(
          child: state.studentsPerformanceInSchool != null
              ? TopStudentsList(
                  topStudents: state.studentsPerformanceInSchool!.topStudents,
                  currentStudent: widget.studentProfile,
                )
              : const Center(
                  child: Text('No school performance data available')),
        ),
      ],
    );
  }

  Widget _buildSessionAnalysisTab(StudentPerformanceLoaded state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          // Session selector
          _buildSessionSelector(),
          const SizedBox(height: 16),
          if (state.performanceBySession != null &&
              state.performanceBySession!.isNotEmpty)
            SessionPerformanceChart(
              performances: state.performanceBySession!,
              studentProfile: widget.studentProfile,
            )
          else
            Container(
              height: 300,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text('No session performance data available'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSessionSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Session for Analysis',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.sessionsList.length,
              itemBuilder: (context, index) {
                final session = widget.sessionsList[index];
                final isSelected = session.id == widget.currentSessionModel.id;

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      if (!isSelected) {
                        _performanceBloc.add(
                          LoadStudentPerformanceBySession(
                            sessionId: session.id.toString(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryColor
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryColor
                              : Colors.grey[300]!,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (session.activeSession)
                            Container(
                              width: 6,
                              height: 6,
                              margin: const EdgeInsets.only(right: 6),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.white : Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                          Text(
                            session.session,
                            style: TextStyle(
                              color:
                                  isSelected ? Colors.white : Colors.grey[700],
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildPerformanceSummaryCard(
  //     StudentPerformanceComparison performance) {
  //   final currentPerformance = performance.overallPerformance.first;
  //   final previousPerformance = performance.overallPerformance.last;
  //   final improvement =
  //       currentPerformance.average - previousPerformance.average;
  //   final positionChange =
  //       previousPerformance.position - currentPerformance.position;
  //
  //   return Container(
  //     decoration: BoxDecoration(
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.15),
  //           spreadRadius: 0,
  //           blurRadius: 10,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //       color: AppColors.white,
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(16),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'Performance Summary',
  //             style: Theme.of(context).textTheme.headlineSmall?.copyWith(
  //                   fontWeight: FontWeight.bold,
  //                   color: AppColors.primaryColor,
  //                 ),
  //           ),
  //           const SizedBox(height: 16),
  //           Row(
  //             children: [
  //               Expanded(
  //                 child: _buildSummaryItem(
  //                   'Current Average',
  //                   '${currentPerformance.average.toStringAsFixed(1)}%',
  //                   AppColors.primaryColor,
  //                   Icons.trending_up,
  //                 ),
  //               ),
  //               Expanded(
  //                 child: _buildSummaryItem(
  //                   'Current Position',
  //                   '#${currentPerformance.position}',
  //                   Colors.green,
  //                   Icons.emoji_events,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 12),
  //           Row(
  //             children: [
  //               Expanded(
  //                 child: _buildSummaryItem(
  //                   'Improvement',
  //                   '${improvement >= 0 ? '+' : ''}${improvement.toStringAsFixed(1)}%',
  //                   improvement >= 0 ? Colors.green : Colors.red,
  //                   improvement >= 0
  //                       ? Icons.arrow_upward
  //                       : Icons.arrow_downward,
  //                 ),
  //               ),
  //               Expanded(
  //                 child: _buildSummaryItem(
  //                   'Position Change',
  //                   '${positionChange > 0 ? '+' : ''}$positionChange',
  //                   positionChange > 0 ? Colors.green : Colors.red,
  //                   positionChange > 0
  //                       ? Icons.arrow_upward
  //                       : Icons.arrow_downward,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget _buildPerformanceSummaryCard(StudentPerformanceComparison performance) {
    // Check if overallPerformance list is empty
    if (performance.overallPerformance.isEmpty) {
      return _buildEmptyPerformanceSummaryCard();
    }

    // Check if we have at least one performance record
    if (performance.overallPerformance.length < 1) {
      return _buildEmptyPerformanceSummaryCard();
    }

    final currentPerformance = performance.overallPerformance.first;

    // Handle case where we only have one performance record (no comparison possible)
    if (performance.overallPerformance.length == 1) {
      return _buildSinglePerformanceSummaryCard(currentPerformance);
    }

    // Safe to access both first and last now
    final previousPerformance = performance.overallPerformance.last;
    final improvement = currentPerformance.average - previousPerformance.average;
    final positionChange = previousPerformance.position - currentPerformance.position;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Performance Summary',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildSummaryItem(
                    'Current Average',
                    '${currentPerformance.average.toStringAsFixed(1)}%',
                    AppColors.primaryColor,
                    Icons.trending_up,
                  ),
                ),
                Expanded(
                  child: _buildSummaryItem(
                    'Current Position',
                    '#${currentPerformance.position}',
                    Colors.green,
                    Icons.emoji_events,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildSummaryItem(
                    'Improvement',
                    '${improvement >= 0 ? '+' : ''}${improvement.toStringAsFixed(1)}%',
                    improvement >= 0 ? Colors.green : Colors.red,
                    improvement >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                  ),
                ),
                Expanded(
                  child: _buildSummaryItem(
                    'Position Change',
                    '${positionChange > 0 ? '+' : ''}$positionChange',
                    positionChange > 0 ? Colors.green : Colors.red,
                    positionChange > 0 ? Icons.arrow_upward : Icons.arrow_downward,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildEmptyPerformanceSummaryCard() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Performance Summary',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.assessment_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Performance Data Available',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Performance data will appear here once available',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
  Widget _buildSinglePerformanceSummaryCard(OverallPerformance currentPerformance) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Performance Summary',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildSummaryItem(
                    'Current Average',
                    '${currentPerformance.average.toStringAsFixed(1)}%',
                    AppColors.primaryColor,
                    Icons.trending_up,
                  ),
                ),
                Expanded(
                  child: _buildSummaryItem(
                    'Current Position',
                    '#${currentPerformance.position}',
                    Colors.green,
                    Icons.emoji_events,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue[600], size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Comparison data will be available with more performance records',
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
      String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: color.withOpacity(0.8),
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectImprovementChart(
      StudentPerformanceComparison performance) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Subject Performance Comparison',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: SubjectImprovementChart(
                subjectImprovements: performance.subjectImprovements,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.primaryColor.withOpacity(0.8)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: Text(
              widget.studentProfile.studentFullname[0].toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.studentProfile.studentFullname}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${widget.classModel.nameOfClassType} Class',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.currentSessionModel.session,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
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
              widget.schoolModel.name.split(' ').first,
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

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Error Loading Data',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<StudentPerformanceBloc>().add(const RefreshData());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
