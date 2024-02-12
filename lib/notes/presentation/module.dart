import 'package:currency_exchange/app/cubit/layout_cubit.dart';
import 'package:currency_exchange/app/theme.dart';
import 'package:currency_exchange/notes/bloc/note_bloc.dart';
import 'package:currency_exchange/notes/models/note_model.dart';
import 'package:currency_exchange/notes/presentation/widgets/creating_note_app_bar.dart';
import 'package:currency_exchange/notes/presentation/widgets/view_edit_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class NotesModule extends StatefulWidget {
  const NotesModule({
    super.key,
    required this.notesWidth,
    required this.notesHeight,
  });

  final double notesWidth;
  final double notesHeight;

  @override
  State<NotesModule> createState() => _NotesModuleState();
}

class _NotesModuleState extends State<NotesModule> {
  bool isCreating = false;
  bool isEditing = false;
  Note? selectedNote; // for show note after press on in list

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: widget.notesWidth,
      height: widget.notesHeight,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: BaseColors.headerText,
              width: 2,
            ),
            color: BaseColors.background),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: BlocBuilder<LayoutCubit, LayoutState>(
            builder: (context, state) {
              if (state == LayoutState.bothWithHistory) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      color: BaseColors.headerText,
                      thickness: 2,
                    ),
                  ),
                );
              }
              return Scaffold(
                appBar: AppBar(
                  leading: isCreating
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              isCreating = !isCreating;
                              // clear text fields
                              titleController.clear();
                              contentController.clear();
                            });
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: BaseColors.headerText,
                          ),
                        )
                      : selectedNote == null
                          ? null
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedNote = null;
                                });
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: BaseColors.headerText,
                                size: 20,
                              ),
                            ),
                  title: isCreating
                      ? CreatingNotesAppBar(titleController: titleController)
                      : selectedNote == null
                          ? Text('Notes',
                              style: GoogleFonts.candal(
                                  color: BaseColors.headerText,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold))
                          : ViewEditField(
                              titleController: titleController,
                              isEditing: isEditing),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  actions: isCreating
                      ? []
                      : selectedNote != null
                          ? getActionsForViewNote(context)
                          : getActionsForViewAllNotes(context),
                ),
                body: isCreating
                    ? _buildCreateNote()
                    : selectedNote == null
                        ? _buildViewAllNotes()
                        : _buildViewNote(),
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> getActionsForViewNote(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              isEditing = !isEditing;
            });
          },
          child: Container(
            width: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isEditing
                  ? BaseColors.layoutButtonActive
                  : BaseColors.layoutButton,
              border: Border.all(
                  color: isEditing
                      ? BaseColors.layoutButtonActiveBorder
                      : BaseColors.textFieldBorder,
                  width: 2),
            ),
            child: Icon(
              Icons.edit,
              color: isEditing
                  ? BaseColors.layoutButtonActiveText
                  : BaseColors.headerText,
              size: 15,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            context.read<NoteBloc>().add(DeleteNote(selectedNote!.id!));
            setState(() {
              selectedNote = null;
            });
          },
          child: Container(
            width: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: BaseColors.layoutButton,
              border: Border.all(color: BaseColors.headerText, width: 2),
            ),
            child: const Icon(
              Icons.delete,
              color: BaseColors.headerText,
              size: 15,
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> getActionsForViewAllNotes(BuildContext context) {
    return [
      GestureDetector(
        onTap: () {
          context.read<NoteBloc>().add(FetchNotes());
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.refresh,
            color: BaseColors.headerText,
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          // change to create note
          setState(() {
            isCreating = !isCreating;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add,
                color: BaseColors.headerText,
              ),
              Text(
                'Create',
                style: GoogleFonts.candal(
                    color: BaseColors.headerText,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      )
    ];
  }

  BlocBuilder<NoteBloc, NoteState> _buildViewAllNotes() {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        // context.read<NoteBloc>().add(FetchNotes());
        if (state is NotesInitial) {
          return const Center(
            child: CircularProgressIndicator(
              color: BaseColors.headerText,
            ),
          );
        } else if (state is NotesLoaded) {
          return ListView.builder(
            itemCount: state.notes.length,
            itemBuilder: (context, index) {
              final note = state.notes[index];
              return ListTile(
                title: Text(
                  note.title!,
                  overflow: TextOverflow.fade,
                  style: GoogleFonts.candal(
                      color: BaseColors.headerText,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  note.content!,
                  style: GoogleFonts.candal(
                      color: BaseColors.headerText.withOpacity(0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  setState(() {
                    selectedNote = note;
                    titleController.text = note.title!;
                    contentController.text = note.content!;
                  });
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: BaseColors.headerText),
                  onPressed: () {
                    context.read<NoteBloc>().add(DeleteNote(note.id!));
                  },
                ),
              );
            },
          );
        } else if (state is NotesError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(
            color: BaseColors.headerText,
          ));
        }
      },
    );
  }

  Widget _buildCreateNote() {
    final layoutState = context.read<LayoutCubit>().state;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormField(
            cursorColor: BaseColors.headerText,
            controller: contentController,
            maxLines: layoutState == LayoutState.both ? 4 : 12,
            style: GoogleFonts.candal(
                color: BaseColors.headerText,
                fontSize: 14,
                fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintText: 'Content',
              hintStyle: GoogleFonts.candal(
                  color: BaseColors.headerText.withOpacity(0.5),
                  fontSize: 14,
                  fontWeight: FontWeight.w300),
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: BaseColors.headerText,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: BaseColors.headerText,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: BaseColors.headerText,
                  width: 2,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                context
                    .read<NoteBloc>()
                    .add(AddNote(titleController.text, contentController.text));
                setState(() {
                  isCreating = !isCreating;
                  // clear text fields
                  titleController.clear();
                  contentController.clear();
                });
              },
              child: Container(
                width: 150,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: BaseColors.button,
                  border: Border.all(color: BaseColors.headerText, width: 2),
                ),
                child: Center(
                  child: Text(
                    'Save',
                    style: GoogleFonts.candal(
                        color: BaseColors.headerText,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildViewNote() {
    final layoutState = context.read<LayoutCubit>().state;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormField(
            cursorColor: BaseColors.headerText,
            controller: contentController,
            enabled: isEditing,
            maxLines: layoutState == LayoutState.both ? 4 : 12,
            style: GoogleFonts.candal(
                color: BaseColors.headerText,
                fontSize: 14,
                fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintText: 'Content',
              hintStyle: GoogleFonts.candal(
                  color: BaseColors.headerText.withOpacity(0.5),
                  fontSize: 14,
                  fontWeight: FontWeight.w300),
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: BaseColors.headerText,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: BaseColors.headerText,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: BaseColors.headerText,
                  width: 2,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                context.read<NoteBloc>().add(UpdateNote(
                    selectedNote!.id!,
                    Note()
                      ..id = selectedNote!.id!
                      ..title = titleController.text
                      ..content = contentController.text));
                setState(() {
                  isCreating = !isCreating;
                  // clear text fields
                  titleController.clear();
                  contentController.clear();
                });
              },
              child: Container(
                width: 150,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: BaseColors.button,
                  border: Border.all(color: BaseColors.headerText, width: 2),
                ),
                child: Center(
                  child: Text(
                    'Update',
                    style: GoogleFonts.candal(
                        color: BaseColors.headerText,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
