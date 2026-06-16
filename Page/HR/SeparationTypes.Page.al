page 50473 "Separation Type Setup"
{
    // version TL2.0

    PageType = List;
    SourceTable = 50238;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Separation Type"; Rec."Separation Type")
                {
                    ApplicationArea = All;
                }
                field("Notice Period"; Rec."Notice Period")
                {
                    ApplicationArea = All;
                }
                field("Golden Handshake"; Rec."Golden Handshake")
                {
                    ApplicationArea = All;
                }
                field("Transport Allowance"; Rec."Transport Allowance")
                {
                    ApplicationArea = All;
                }
                field("Service Pay"; Rec."Service Pay")
                {
                    ApplicationArea = All;
                }
                field("No. of Months Salary"; Rec."No. of Months Salary")
                {
                    ApplicationArea = All;
                }
                field("Notification Type"; Rec."Notification Type")
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
