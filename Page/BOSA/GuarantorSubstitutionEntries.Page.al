page 50278 "Guarantor Substitution Entries"
{
    // version TL2.0

    Editable = false;
    PageType = List;
    SourceTable = "Guarantor Substitution Entry";
    UsageCategory = History;
    ApplicationArea = All;
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
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Security Type"; Rec."Security Type")
                {
                    ApplicationArea = All;
                }
                field("Previous Guarantor No."; Rec."Previous Guarantor No.")
                {
                    ApplicationArea = All;
                }
                field("Previous Guarantor Name"; Rec."Previous Guarantor Name")
                {
                    ApplicationArea = All;
                }
                field("New Guarantor No."; Rec."New Guarantor No.")
                {
                    ApplicationArea = All;
                }
                field("Previous Amount Guaranteed"; Rec."Previous Amount Guaranteed")
                {
                    ApplicationArea = All;
                }
                field("New Guarantor Name"; Rec."New Guarantor Name")
                {
                    ApplicationArea = All;
                }
                field("New Amount Guaranteed"; Rec."New Amount Guaranteed")
                {
                    ApplicationArea = All;
                }
                field("Substitution Date"; Rec."Substitution Date")
                {
                    ApplicationArea = All;
                }
                field("Substitution Time"; Rec."Substitution Time")
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

