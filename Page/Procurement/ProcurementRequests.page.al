page 50898 "Procurement Requests"
{

    Caption = 'Procurement Requests';
    PageType = List;
    SourceTable = "Procurement Request";
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = All;
                }
                field("Procurement Plan No."; Rec."Procurement Plan No.")
                {
                    ApplicationArea = All;
                }
                field("Process Status"; Rec."Process Status")
                {
                    ApplicationArea = All;
                }
                field("Assigned User"; Rec."Assigned User")
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {

                }
            }
        }
    }

}
