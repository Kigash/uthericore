page 50480 "Qualifications Subform"
{
    // version TL2.0

    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = 50248;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Qualification Type"; Rec."Qualification Type")
                {
                    ApplicationArea = All;
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    Caption = 'Qualification';
                    ApplicationArea = All;
                }
                field(Qualification; Rec.Qualification)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                }
                field("Score ID"; Rec."Score ID")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}
