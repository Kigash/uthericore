page 50011 "Member Card"
{
    // version TL2.0

    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Related,Accounts,Category 6,Category 7,Category 8';
    SourceTable = Member;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            field(Category; Rec.Category)
            {
                Visible = false;
                trigger OnValidate()
                begin
                    SetVisible;
                end;
            }
            group(Individual)
            {
                Caption = 'Individual';
                Visible = IsVisibleIndividual;
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }

                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = All;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }
                field("National ID"; Rec."National ID")
                {
                    ApplicationArea = All;
                }
                field("Passport ID"; Rec."Passport ID")
                {
                    ApplicationArea = All;
                }
                field("Age Classification"; Rec."Age Classification")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                }
                field(AccountCat; Rec.Category)
                {
                    Caption = 'Account Category';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sub Category"; Rec."Sub Category")
                {
                    Caption = 'Account Sub Category';
                    ApplicationArea = All;
                }
                field(Occupation; Rec.Occupation)
                {
                    ApplicationArea = All;
                }
                group("GroupLink")
                {
                    Caption = '';
                    Visible = Rec.Category = 0;
                    field("Group Link Type"; Rec."Group Link Type")
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            Rec."Group Link No." := '';
                        end;
                    }
                    group(GroupLinkNo)
                    {
                        Caption = '';
                        Visible = Rec."Group Link Type" > 0;
                        field("Group Link No."; Rec."Group Link No.")
                        {
                            ApplicationArea = All;
                        }
                    }

                }
                field("Introducer Member No."; Rec."Introducer Member No.")
                {
                    ApplicationArea = All;
                }
                field("Introducer Member Name"; Rec."Introducer Member Name")
                {
                    ApplicationArea = All;
                }
                field("PIN No."; Rec."PIN No.")
                {
                    ApplicationArea = All;
                }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = All;
                }
                field("Payroll No."; Rec."Payroll No.")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = All;
                }
                field("Checkoff Company Code"; Rec."Checkoff Company Code")
                {
                    ApplicationArea = All;
                }
                field("Checkoff Company Name"; Rec."Checkoff Company Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                group(IsGroupOfficial)
                {
                    Caption = '';
                    Visible = Rec."Group Link Type" > 0;
                    field("Is Group Official"; Rec."Is Group Official")
                    {
                        ApplicationArea = All;
                    }
                }
                group(GroupOfficialPosition)
                {
                    Caption = '';
                    Visible = Rec."Is Group Official" = true;
                    field("Group Official Position"; Rec."Group Official Position")
                    {
                        ApplicationArea = All;
                    }
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Group Details")
            {
                Caption = 'Group';
                Visible = IsVisibleGroup;
                field("Group Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }
                field("Group Registration No."; Rec."Registration No.")
                {
                    Caption = ' Registration No.';
                    ApplicationArea = All;
                }
                field("Group Date of Registration"; Rec."Date of Registration")
                {
                    Caption = ' Date of Registration';
                    ApplicationArea = All;
                }

                // field("<Group Date of Renewal>"; Rec."Date of Renewal")
                // {
                //     Caption = ' Date of Renewal';
                // }
                field("Group Meeting Day"; Rec."Group Meeting Day")
                {
                    ApplicationArea = All;
                }
                field("Group Meeting Time"; Rec."Group Meeting Time")
                {
                    ApplicationArea = All;
                }
                field("Group Meeting Frequency Option"; Rec."Group Meeting Frequency Option")
                {
                    ApplicationArea = All;
                }
                field("Group Meeting Venue"; Rec."Group Meeting Venue")
                {
                    ApplicationArea = All;
                }
                field("Last Meeting Date"; Rec."Last Meeting Date")
                {
                    ApplicationArea = All;
                }
                field("Min. Contribution per Meeting"; Rec."Min. Contribution per Meeting")
                {
                    ApplicationArea = All;
                }

                field("Office Location"; Rec."Office Location")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("No. of Members"; Rec."No. of Members")
                {
                    ApplicationArea = All;
                }
                field("Group Paybill Code"; Rec."Group Paybill Code")
                {
                    ApplicationArea = All;
                }

                field("Group Loan Officer ID"; Rec."Loan Officer ID")
                {
                    ApplicationArea = All;
                }
                field("Group Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }

                field(GroupStatus; Rec.Status)
                {
                    ApplicationArea = All;
                }

            }
            group("Company Details")
            {
                Caption = 'Company';
                Visible = IsVisibleCompany;
                field("Company Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }
                field("Registration No."; Rec."Registration No.")
                {
                    ApplicationArea = All;
                }

                field("Date of Registration"; Rec."Date of Registration")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }

                field("Company Activity"; Rec.Activity)
                {
                    Caption = 'Company Activity';
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Company KRA PIN"; Rec."PIN No.")
                {
                    Caption = ' KRA PIN';
                    ShowMandatory = true;
                    ApplicationArea = All;
                }

                field("Company Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(CompanyStatus; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            group(Joint)
            {
                Caption = 'Joint';
                Visible = IsVisibleJoint;
                field("Joint Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }
                field("Joint ID"; Rec."National ID")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Joint Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(JointStatus; Rec.Status)
                {
                    ApplicationArea = All;
                }

            }

            group(Communication)
            {
                field("E-mail"; Rec."E-mail")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Phone No. 2"; Rec."Phone No. 2")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = All;
                }
                field("Physical Address"; Rec."Physical Address")
                {
                    ApplicationArea = All;
                }
                group("Residence")
                {
                    Caption = '';
                    Visible = Rec.Category = 0;
                    field("Current Residence"; Rec."Current Residence")
                    {
                        ApplicationArea = All;
                    }
                    field("Home Ownership"; Rec."Home Ownership")
                    {
                        ApplicationArea = All;
                    }
                    field("Home Village"; Rec."Home Village")
                    {
                        ApplicationArea = All;
                    }
                    field("Nearest LandMark"; Rec."Nearest LandMark")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            group(Audit)
            {
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created Time"; Rec."Created Time")
                {
                    ApplicationArea = All;
                }
                field("Created By Host Name"; Rec."Created By Host Name")
                {
                    ApplicationArea = All;
                }
                field("Created By Host IP"; Rec."Created By Host IP")
                {
                    ApplicationArea = All;
                }
                field("Created By Host MAC"; Rec."Created By Host MAC")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Page; 50041)
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
            }
            part("Member Picture"; "Member Picture")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                Visible = IsVisiblePicture;
            }

            part("Member Front ID"; "Member Front ID")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                Visible = IsVisibleFrontID;
            }
            part("Member Back ID"; "Member Back ID")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                Visible = IsVisibleBackID;
            }
            part("Member Signature"; "Member Signature")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                Visible = IsVisibleSignature;
            }
            part("Member Reg. Certficate"; "Member Reg. Certficate")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                Visible = IsVisibleCR;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Bank Accounts")
            {
                ApplicationArea = All;
                Ellipsis = true;
                Image = BankAccount;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = page "Member Bank Accounts List";
                RunPageLink = "Member No." = field("No.");
            }
            action("Member Nominees")
            {
                ApplicationArea = All;
                Ellipsis = true;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleIndividual;
                RunObject = page Nominees;
                // RunPageLink = "Application No." = field("Application No.");
                RunPageLink = "Application No." = field("No.");
            }
            action("Next of Kin")
            {
                Ellipsis = true;
                Image = Hierarchy;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                // Visible = IsVisibleIndividual;
                Visible = false;

                ApplicationArea = All;
                RunObject = page "Next of Kin";
                RunPageLink = "Application No." = field("No.");

            }
            action("Next of Kin1")
            {
                Caption = 'Next of Kin';
                Ellipsis = true;
                Image = Hierarchy;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleIndividual;


                ApplicationArea = All;
                trigger OnAction()
                begin
                    if Rec."Application No." = '' then
                        BeneficiaryType.SetRange("Application No.", Rec."No.");
                    if rec."Application No." <> '' then
                        BeneficiaryType.SETRANGE("Application No.", Rec."Application No.");
                    BeneficiaryType.FILTERGROUP(10);
                    BeneficiaryType.SETRANGE(Type, BeneficiaryType.Type::"Next of Kin");
                    BeneficiaryType.FILTERGROUP(0);
                    PAGE.RUN(50006, BeneficiaryType);
                end;
            }
            action("JA Member Nominees")
            {
                ApplicationArea = All;
                Ellipsis = true;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleJoint;
                RunObject = page Nominees;
                RunPageLink = "Application No." = field("Application No.");
            }
            action("JA Next of Kin")
            {
                Ellipsis = true;
                Image = Hierarchy;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleJoint;
                ApplicationArea = All;
                RunObject = page "Next of Kin";
                RunPageLink = "Application No." = field("Application No.");
            }
            action(Agencies)
            {
                Image = ContactPerson;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;//IsVisibleIndividual;
                ApplicationArea = All;
                RunObject = page "Member Agencies";
                RunPageLink = "Application No." = field("No.");
            }
            action("Monthly Contributions")
            {
                Ellipsis = true;
                Image = ElectronicPayment;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                RunObject = page "Member Contribution";
                RunPageLink = "Application No." = field("No.");
            }
            action("Group Members")
            {
                Image = ContactPerson;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleGroup;
                ApplicationArea = All;
                RunObject = page "Group Member";
                RunPageLink = "Application No." = field("Application No.");

            }
            action("Group Trustees")
            {
                Image = Trace;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleGroup;
                ApplicationArea = All;
                RunObject = page "Group Trustee";
                RunPageLink = "Application No." = field("Application No.");

            }
            action("Company Signatories")
            {
                Image = Company;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleCompany;
                ApplicationArea = All;
                RunObject = page "Company Trustee";
                RunPageLink = "Application No." = field("No.");

            }

            action("Joint Members")
            {
                Image = Holiday;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsVisibleJoint;
                ApplicationArea = All;
                // RunObject = page joint;

            }
            action("Savings/Deposit Accounts")
            {
                Image = MapAccounts;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                RunObject = page "Member S/Dep. Account List";
                RunPageLink = "Member No." = field("No.");

            }
            action("Loan Accounts")
            {
                Image = SocialListening;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                //RunObject = page "Member Loan Account List";
                //RunPageLink = "Member No." = field("No.");
                trigger OnAction()
                var
                    LoanAc: Record "Loan Application";
                begin
                    //Message('Loan Accounts');
                    LoanAc.FILTERGROUP(10);
                    LoanAc.Reset();
                    LoanAc.SETRANGE("Member No.", Rec."No.");
                    LoanAc.FILTERGROUP(0);
                    PAGE.RUN(50207, LoanAc);
                end;
            }

            action("Check Dividend Balance")
            {
                Caption = 'Check Dividend Balance';
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Vendor: Record Vendor;
                    AccountType: Record "Account Type";
                    GlobalManagement: Codeunit "Global Management";
                    AccountTypeEnum: Enum "Gen. Journal Account Type";
                    Balance: Decimal;
                begin
                    Vendor.RESET;
                    Vendor.SETRANGE("Member No.", Rec."No.");
                    IF Vendor.FINDSET THEN BEGIN
                        REPEAT
                            AccountType.GET(Vendor."Account Type");
                            Balance := GlobalManagement.GetAccountBalanceDividend(AccountTypeEnum::Vendor, Vendor."No.", TODAY);
                            Message('Account: %1\Name: %2\Type: %3\Balance: %4',
                                Vendor."No.", Vendor.Name, AccountType.Type, Balance);
                        UNTIL Vendor.NEXT = 0;
                    END;
                end;
            }
            group(Reports)
            {
                action(Statement)
                {
                    Image = SocialListening;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        Vendor.FILTERGROUP(10);
                        Vendor.SETRANGE("Member No.", Rec."No.");
                        Vendor.FILTERGROUP(0);
                        Report.RUN(50082, true, false, Vendor);
                    end;
                }
                action(OrdinaryAcc)
                {
                    Caption = 'Ordinary Account';
                    Image = SocialListening;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        FosaM: Codeunit "FOSA Management";
                    begin
                        Member.Reset();
                        if Member.FindSet() then begin
                            repeat
                                FosaM.CreateDefaultAccount(Member);
                            until Member.Next = 0;
                        end;
                        Message('Member Ordinary Account is %1', FosaM.GetOrdinaryMemberAccount(Rec));
                    end;
                }

                action(LoanStatement)
                {
                    Caption = 'Loan Statement';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        LoanApplication.FILTERGROUP(10);
                        LoanApplication.SETRANGE("Member No.", Rec."No.");
                        LoanApplication.FILTERGROUP(0);
                        Report.RUN(50081, true, false, LoanApplication);
                    end;
                }
                action("Member Statement-Combined")
                {
                    Caption = 'Member Statement-Combined';
                    Image = BankAccountStatement;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.FILTERGROUP(10);
                        Rec.SETRANGE("No.", Rec."No.");
                        Rec.SetRange("No.", Rec."No.");
                        Rec.FILTERGROUP(0);
                        Report.RUN(50087, true, false, Rec);
                    end;
                }

                action("Send Member Statement Via Email")
                {
                    Caption = 'Send Member Statement Via Email';
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        MailText: array[10] of Text;
                        FileName: array[10] of Text;
                        MailHeader: Label 'MEMBER STATEMENT';
                        MailBody001: Label 'Dear %1,<br><br>';
                        MailBody002: Label 'Please find attached your member statement.<br><br>';
                        MailBody003: Label 'Kind Regards, <br><br>';
                        MailBody004: Label 'UNILANDS SACCO';
                        SMTPMailSetup: Record "SMTP Mail Setup";
                        SMTPMail: Codeunit "SMTP Mail";
                        GlobalSetup: Record "Global Setup";
                        Member: Record Member;
                    begin
                        Rec.TestField(Rec."E-mail");

                        Member.RESET;
                        Member.SETRANGE("No.", Rec."No.");
                        IF Member.FindFirst() THEN BEGIN
                            GlobalSetup.Get();
                            FileName[2] := CONVERTSTR(FORMAT(TODAY), '/', '_');
                            FileName[2] := CONVERTSTR(FileName[2], '\', '_');
                            FileName[1] := GlobalSetup."Image Path Local Directory" + Member."Full Name" + '_' + FileName[2] + '.pdf';
                            REPORT.SAVEASPDF(50087, FileName[1], Member);
                            MailText[1] := MailHeader;
                            MailText[2] := STRSUBSTNO(MailBody001, Member."Full Name");
                            MailText[2] += MailBody002;
                            MailText[2] += MailBody003;
                            MailText[2] += MailBody004;

                            SMTPMailSetup.GET;
                            SMTPMail.CreateMessage(MailBody004, SMTPMailSetup."User ID", SMTPMailSetup."User ID", MailText[1], MailText[2], TRUE);
                            IF FILE.EXISTS(FileName[1]) THEN
                                //SMTPMail.AddAttachment(FileName[1], Member."Full Name");
                            SMTPMail.Send;
                            IF FILE.EXISTS(FileName[1]) THEN
                                FILE.Erase(FileName[1]);
                            Message('E-mail sent successfully');
                        END;
                    end;
                }

                action(LoanGuaranteed)
                {
                    Caption = 'Loans Guaranteed';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        Rec.SETRANGE("No.", Rec."No.");
                        Rec.SetRange("No.", Rec."No.");
                        Rec.FILTERGROUP(0);
                        Report.RUN(50006, true, false, Rec);
                    end;
                }

                action(LoanGuarantors)
                {
                    Caption = 'Loan Guarantors';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        LoanApplication.FILTERGROUP(10);
                        LoanApplication.SETRANGE("Member No.", Rec."No.");
                        LoanApplication.FILTERGROUP(0);
                        Report.RUN(50086, true, false, LoanApplication);
                    end;
                }
                action(CreateMissingAccount)
                {
                    Caption = 'CreateMissingAccount';
                    Image = Print;
                    Promoted = true;
                    Visible = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        Length: Integer;
                        vendL: Record "Vendor Ledger Entry";
                        GrImp: Record GroupBalances;
                        BoreshaAc: Code[20];
                        NextGenAc: code[20];
                        FosaM: Codeunit "FOSA Management";
                        GlobalM: Codeunit "Global Management";
                        GroupNo: Code[100];
                        AccountTypeEnum: Enum "Gen. Journal Account Type";
                        AppliesToDocTypeEnum: Enum "Gen. Journal Document Type";
                    begin
                        If UserId = 'EC2AMAZ-96OA7ED\ADMINISTRATOR' then begin
                            /*GrImp.Reset();
                            If GrImp.FindSet() then begin
                                repeat
                                    Member.Init();
                                    if StrLen(GrImp."Member No.") = 1 then begin
                                        Member."No." := 'GR0000000' + GrImp."Member No."; //GR00000001
                                    end else begin
                                        if StrLen(GrImp."Member No.") = 2 then begin
                                            Member."No." := 'GR000000' + GrImp."Member No.";
                                        end;
                                        if StrLen(GrImp."Member No.") = 3 then begin
                                            Member."No." := 'GR00000' + GrImp."Member No.";
                                        end;
                                    end;
                                    Member."Full Name" := GrImp."Member Name";
                                    Member.Category := Member.Category::Group;
                                    Member.Insert();
                                until GrImp.Next = 0;
                            end;

                            Member.Reset();
                            Member.SetRange(Category, Member.Category::Group);
                            if Member.FindSet then begin
                                repeat
                                    AccountType.RESET;
                                    AccountType.SETRANGE("Applies to Member Category", AccountType."Applies to Member Category"::Group);
                                    if AccountType.FindSet() then begin
                                        repeat
                                            Vendor.Reset();
                                            Vendor.SetRange("Member No.", Member."No.");
                                            Vendor.SetRange(Vendor."No.", AccountType.Code);
                                            if not Vendor.FindFirst then begin
                                                AccountNo := Member."No." + AccountType.Code;
                                                Vendor.INIT;
                                                Vendor."No." := AccountNo;
                                                Vendor.Name := AccountType.Description;
                                                Vendor."Vendor Posting Group" := AccountType."Posting Group";
                                                Vendor."Global Dimension 1 Code" := "Global Dimension 1 Code";
                                                Vendor."Phone No." := Member."Phone No.";
                                                Vendor."E-Mail" := Member."E-mail";
                                                Vendor."Account Type" := AccountType.Code;
                                                Vendor."Member No." := Member."No.";
                                                Vendor.Status := Vendor.Status::Active;
                                                Vendor."Member Name" := Member."Full Name";
                                                Vendor."Vendor Type" := Vendor."Vendor Type"::FOSA;
                                                Vendor.INSERT;
                                            end;
                                        until AccountType.Next = 0;
                                    end;
                                until Member.Next = 0;
                            end;*/

                            GlobalM.ClearJournal('GENERAL', 'MIGRATION');
                            GrImp.Reset();
                            If GrImp.FindSet() then begin
                                repeat
                                    GroupNo := '';
                                    if StrLen(GrImp."Member No.") = 1 then begin
                                        GroupNo := 'GR0000000' + GrImp."Member No."; //GR00000001
                                    end else begin
                                        if StrLen(GrImp."Member No.") = 2 then begin
                                            GroupNo := 'GR000000' + GrImp."Member No.";
                                        end;
                                        if StrLen(GrImp."Member No.") = 3 then begin
                                            GroupNo := 'GR00000' + GrImp."Member No.";
                                        end;
                                    end;
                                    if GrImp."Shares Balance" > 0 then begin
                                        GlobalM.CreateJournal('GENERAL', 'MIGRATION', 'DATAMIGRATION', '', 20230331D, AccountTypeEnum::Vendor, GroupNo + '08', 'Group Shares' + ' -' + GrImp."Member Name" + ' Bal C/f',
                                        -GrImp."Shares Balance", '', '', '', Member."Global Dimension 1 Code", AccountTypeEnum::"G/L Account", '400441000000000200', AppliesToDocTypeEnum::" ", '');
                                    end;
                                    if GrImp."Savings Balance" > 0 then begin
                                        GlobalM.CreateJournal('GENERAL', 'MIGRATION', 'DATAMIGRATION', '', 20230331D, AccountTypeEnum::Vendor, GroupNo + '09', 'Group Savings' + ' -' + GrImp."Member Name" + ' Bal C/f',
                                        -GrImp."Savings Balance", '', '', '', Member."Global Dimension 1 Code", AccountTypeEnum::"G/L Account", '400441000000000200', AppliesToDocTypeEnum::" ", '');
                                    end;
                                    if GrImp."Ordinary Balance" > 0 then begin
                                        GlobalM.CreateJournal('GENERAL', 'MIGRATION', 'DATAMIGRATION', '', 20230331D, AccountTypeEnum::Vendor, GroupNo + '10', 'Group Ordinary Savings' + ' -' + GrImp."Member Name" + ' Bal C/f',
                                        -GrImp."Ordinary Balance", '', '', '', Member."Global Dimension 1 Code", AccountTypeEnum::"G/L Account", '400441000000000200', AppliesToDocTypeEnum::" ", '');
                                    end;
                                until GrImp.Next = 0;
                            end;
                            //GlobalM.PostJournal('GENERAL', 'MIGRATION');
                            Message('Done!');
                        end;
                    end;
                }
            }
        }

        area(Processing)
        {
            action("Send SMS")
            {
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;


                trigger OnAction()
                begin

                end;
            }

        }

    }

    trigger OnOpenPage()
    begin
        SetVisible;
        SetEditable;
        Rec."Registration Date" := Rec."Date of Registration";
        Rec.MODIFY;
        ApplicationN0 := '';

    end;

    var
        Text000: Label 'Are you sure you want to send member application %1 for approval?';
        Text001: Label 'Are you sure you want to cancel member application %1?';
        Text002: Label 'Member Application %1 has been submitted successfully';
        Text003: Label 'Member Application %1 has been cancelled successfully';
        [InDataSet]
        IsVisibleIndividual: Boolean;
        [InDataSet]
        IsVisibleGroup: Boolean;
        [InDataSet]
        IsVisibleCompany: Boolean;
        BeneficiaryType: Record "Beneficiary Type";
        IsVisibleApprovalRequest: Boolean;
        //ApprovalsMgmt: Codeunit "1535";
        Agency: Record "Member Agency";
        AccountType: Record "Account Type";
        Fosa: Codeunit "FOSA Management";
        Member: Record Member;
        AccountNo: code[20];
        MemberMonthlyContribution: Record "Member Contribution";
        IsVisibleJoint: Boolean;
        IsVisibleSignature: Boolean;
        [InDataSet]
        IsVisiblePicture: Boolean;
        [InDataSet]
        IsVisibleFrontID: Boolean;
        [InDataSet]
        IsVisibleBackID: Boolean;
        IsVisibleCR: Boolean;
        Vendor: Record "Vendor";
        ApplicationN0: Code[50];
        Customer: Record "Customer";
        LoanApplication: Record "Loan Application";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        i: Integer;
        TransactionType: Code[10];
        MiniTransactions: Text;

    local procedure SetVisible()
    begin
        IF (Rec.Category = Rec.Category::Individual) or (Rec.Category = Rec.Category::Junior) THEN BEGIN
            IsVisibleGroup := FALSE;
            IsVisibleCompany := FALSE;
            IsVisibleIndividual := TRUE;
            IsVisibleJoint := FALSE;
            IsVisiblePicture := TRUE;
            IsVisibleSignature := TRUE;
            IsVisibleBackID := TRUE;
            IsVisibleFrontID := TRUE;
            IsVisibleCR := FALSE;
        END ELSE
            IF Rec.Category = Rec.Category::Group THEN BEGIN
                IsVisibleIndividual := FALSE;
                IsVisibleCompany := FALSE;
                IsVisibleGroup := TRUE;
                IsVisibleJoint := FALSE;
                IsVisiblePicture := TRUE;
                IsVisibleSignature := FALSE;
                IsVisibleFrontID := FALSE;
                IsVisibleBackID := FALSE;
                IsVisibleCR := TRUE;
            END ELSE
                IF Rec.Category = Rec.Category::Company THEN BEGIN
                    IsVisibleIndividual := FALSE;
                    IsVisibleGroup := FALSE;
                    IsVisibleCompany := TRUE;
                    IsVisibleJoint := FALSE;
                    IsVisiblePicture := TRUE;
                    IsVisibleSignature := FALSE;
                    IsVisibleFrontID := FALSE;
                    IsVisibleBackID := FALSE;
                    IsVisibleCR := TRUE;
                END ELSE
                    IF Rec.Category = Rec.Category::Joint THEN BEGIN
                        IsVisibleGroup := FALSE;
                        IsVisibleCompany := FALSE;
                        IsVisibleIndividual := FALSE;
                        IsVisibleJoint := TRUE;
                        IsVisiblePicture := TRUE;
                        IsVisibleSignature := FALSE;
                        IsVisibleFrontID := FALSE;
                        IsVisibleBackID := FALSE;
                        IsVisibleCR := FALSE;
                    END;
        IF Rec.Status = Rec.Status::Active THEN
            IsVisibleApprovalRequest := TRUE
        ELSE
            IsVisibleApprovalRequest := FALSE
    end;

    local procedure SetEditable()
    begin
        IF Rec.Status = Rec.Status::Active THEN
            CurrPage.EDITABLE := TRUE;
        IF Rec.Status = Rec.Status::Dormant THEN
            CurrPage.EDITABLE := TRUE;
        IF Rec.Status = Rec.Status::Suspended THEN
            CurrPage.EDITABLE := FALSE;
    end;

    trigger OnClosePage()
    var

    begin
        CurrPage.Update(true);
    end;
}
