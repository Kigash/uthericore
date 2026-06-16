page 50980 "Transfer Files Subform"
{
    // version TL2.0

    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Transfer Files Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File No"; Rec."File No")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("File Number"; Rec."File Number")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ID No"; Rec."ID No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payroll No"; Rec."Payroll No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Released From"; Rec."Released From")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Time Released"; Rec."Time Released")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Released To"; Rec."Released To")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Received By"; Rec."Received By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Time Received"; Rec."Time Received")
                {
                    ApplicationArea = All;
                }
                field("Current User ID"; Rec."Current User ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        User.GET(USERID);
    end;

    var
        User: Record "User Setup";
        TransferFilesLines: Record "Transfer Files Line";
}

