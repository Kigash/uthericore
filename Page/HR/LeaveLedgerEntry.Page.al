page 50413 "Leave Ledger Entry"
{
    // version TL2.0

    PageType = List;
    Editable=false;
    SourceTable = 50209;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;
                }
                field("Leave Code"; Rec."Leave Code")
                {
                    ApplicationArea = All;
                }
                field(Days; Rec.Days)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Lost Days"; Rec."Lost Days")
                {
                    ApplicationArea = All;
                }
                field("Earned Leave Days"; Rec."Earned Leave Days")
                {
                    ApplicationArea = All;
                }
                field("Balance Brought Forward"; Rec."Balance Brought Forward")
                {
                    ApplicationArea = All;
                }
                field(Recall; Rec.Recall)
                {
                    ApplicationArea = All;
                }
                field("Added Back Days"; Rec."Added Back Days")
                {
                    ApplicationArea = All;
                }
                field(Modified; Rec.Modified)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
        }
    }

    var
        LeaveLedgerEntry: Record 50209;
}
