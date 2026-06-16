page 55164 "Pending CTS Entries"
{
    // version CTS2.0

    Editable = false;
    PageType = List;
    SourceTable = "CTS Entry";

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
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Clearance Date"; Rec."Clearance Date")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = All;
                }
                field("Cheque Amount"; Rec."Cheque Amount")
                {
                    ApplicationArea = All;
                }

                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Indicator; Rec.Indicator)
                {
                    ApplicationArea = All;
                }
                field("Unpaid Code"; Rec."Unpaid Code")
                {
                    ApplicationArea = All;
                }
                field("Unpaid Reason"; Rec."Unpaid Reason")
                {
                    ApplicationArea = All;
                }
                field("Amount To Pay"; Rec."Amount To Pay")
                {
                    ApplicationArea = All;
                }
                field(Paid; Rec.Paid)
                {
                    ApplicationArea = All;
                }
                field("Paid Date"; Rec."Paid Date")
                {
                    ApplicationArea = All;
                }
                field("Paid Time"; Rec."Paid Time")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}
