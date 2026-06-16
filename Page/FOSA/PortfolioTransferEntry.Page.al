page 55045 "Portfolio Transfer Entries"
{
    // version MC2.0

    Editable = false;
    PageType = List;
    SourceTable = "Portfolio Transfer Entry";

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
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Transfer Date"; Rec."Transfer Date")
                {
                    ApplicationArea = All;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Transferred Loan Amount"; Rec."Transferred Loan Amount")
                {
                    ApplicationArea = All;
                }
                field("Previous Loan Officer ID"; Rec."Previous Loan Officer ID")
                {
                    ApplicationArea = All;
                }
                field("Previous Branch Code"; Rec."Previous Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Current Loan Officer ID"; Rec."Current Loan Officer ID")
                {
                    ApplicationArea = All;
                }
                field("Current Branch Code"; Rec."Current Branch Code")
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

