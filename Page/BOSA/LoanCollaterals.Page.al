page 50209 "Loan  Collateral List"
{
    // version TL2.0

    PageType = List;
    SourceTable = "Loan Collateral";
    UsageCategory = Lists;
    ApplicationArea = All;
    AutoSplitKey = true;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Security Type Code"; Rec."Security Type Code")
                {
                    ApplicationArea = All;
                }
                field("Security Register Code"; Rec."Security Register Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Security Value"; Rec."Security Value")
                {
                    ApplicationArea = All;
                }
                field("Security Factor"; Rec."Security Factor")
                {
                    ApplicationArea = All;
                }
                field("Guaranteed Amount"; Rec."Guaranteed Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Attach Document")
            {
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            }
            action("Open Attachment")
            {
                Image = OpenJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            }
        }
    }

    var
        filename: Text;
        filename2: Text;
        GlobalSetup: Record "Global Setup";
}

