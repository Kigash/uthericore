page 50301 "Classification Setup"
{
    // version TL2.0

    PageType = List;
    SourceTable = "Loan Classification Setup";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Min. Defaulted Days"; Rec."Min. Defaulted Days")
                {
                    ApplicationArea = All;
                }
                field("Max. Defaulted Days"; Rec."Max. Defaulted Days")
                {
                    ApplicationArea = All;
                }
                field("Provisioning %"; Rec."Provisioning %")
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

