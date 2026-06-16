page 50035 "Member Activation Subform"
{
    // version TL2.0

    AutoSplitKey = true;
    PageType = ListPart;
    PromotedActionCategories = 'New,Process,Reports,Category4,Category5,Category6,Category7,Category8';
    SourceTable = "Member Activation Line";
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field("Current Account Status"; Rec."Current Account Status")
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

